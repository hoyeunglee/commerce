const analytics = require("../db/analytics");
const { success, error } = require("../utils/response");

module.exports.handler = async (event) => {
  try {
    const { customerId } = event.pathParameters;
    const recs = await analytics.getRecommendations(customerId);
    return success(recs);
  } catch (err) {
    return error(err.message);
  }
};