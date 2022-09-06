# frozen_string_literal: true

require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @creator = create(:user)
    @assignee = create(:user)
    @task = create(:task, assigned_user: @assignee, task_owner: @creator)
    @creator_headers = headers(@creator)
    @assignee_headers = headers(@assignee)
  end

  def test_should_list_all_tasks_for_valid_user
    get tasks_path, headers: @creator_headers
    assert_response :success
    response_json = response.parsed_body
    all_tasks = response_json["tasks"]

    pending_tasks_count = Task.where(progress: "pending").count
    completed_tasks_count = Task.where(progress: "completed").count

    assert_equal all_tasks["pending"].length, pending_tasks_count
    assert_equal all_tasks["completed"].length, completed_tasks_count
  end

  def test_should_create_valid_task
    post tasks_path,
      params: { task: { title: "Learn Ruby", task_owner_id: @creator.id, assigned_user_id: @assignee.id } },
      headers: @creator_headers
    assert_response :success
    response_json = response.parsed_body
    assert_equal response_json["notice"], t("successfully_created", entity: "Task")
  end

  def test_assignee_shouldnt_destroy_task
    delete task_path(@task.slug), headers: @assignee_headers
    assert_response :forbidden
    response_json = response.parsed_body
    assert_equal response_json["error"], t("authorization.denied")
  end

  def test_assignee_shouldnt_update_restricted_task_fields
    new_title = "#{@task.title}-(updated)"
    task_params = { task: { title: new_title, assigned_user_id: 1 } }

    assert_no_changes -> { @task.reload.title } do
      put task_path(@task.slug), params: task_params, headers: @assignee_headers
      assert_response :forbidden
    end
  end

  def test_assignee_can_change_status_and_progress_of_task
    task_params = { task: { status: "starred", progress: "completed" } }

    put task_path(@task.slug), params: task_params, headers: @assignee_headers
    assert_response :success
    @task.reload
    assert @task.starred?
    assert @task.completed?
  end

  def test_creator_can_change_status_and_progress_of_task
    task_params = { task: { status: "starred", progress: "completed" } }

    put task_path(@task.slug), params: task_params, headers: @creator_headers
    assert_response :success
    @task.reload
    assert @task.starred?
    assert @task.completed?
  end

  def test_not_found_error_rendered_for_invalid_task_slug
    invalid_slug = "invalid-slug"

    get task_path(invalid_slug), headers: @creator_headers
    assert_response :not_found
    response_json = response.parsed_body
    assert_equal response_json["error"], t("not_found", entity: "Task")
  end
end
