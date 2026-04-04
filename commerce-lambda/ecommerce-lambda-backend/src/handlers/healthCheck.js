const { success } = require("../utils/response");

module.exports.handler = async () => {
  return success({ status: "ok", time: new Date().toISOString() });
};