import axios from "axios";

const login = payload =>
  axios.post("/session", {
    login: payload,
  });

const signup = payload =>
  axios.post("/users", {
    user: payload,
  });

const authApi = {
  login,
  signup,
};

export default authApi;
