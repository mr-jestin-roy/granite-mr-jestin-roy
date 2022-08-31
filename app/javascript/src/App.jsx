import React, { useEffect, useState } from "react";

import { Route, Switch, BrowserRouter as Router } from "react-router-dom";

import { setAuthHeaders } from "apis/axios";
import { initializeLogger } from "common/logger";
import Dashboard from "components/Dashboard";
import PageLoader from "components/PageLoader";
import CreateTask from "components/Tasks/Create";

// previous code if any

const App = () => {
  const [loading, setLoading] = useState(true);
  // previous code if any

  useEffect(() => {
    initializeLogger();
    setAuthHeaders(setLoading);
  }, []);

  if (loading) {
    return (
      <div className="h-screen">
        <PageLoader />
      </div>
    );
  }

  // previous code without changes

  return (
    <Router>
      <Switch>
        <Route exact path="/" render={() => <div>Home Page</div>} />
        <Route exact path="/about" render={() => <div>About</div>} />
        <Route exact component={CreateTask} path="/tasks/create" />
        <Route exact component={Dashboard} path="/dashboard" />
      </Switch>
    </Router>
  );
};

export default App;
