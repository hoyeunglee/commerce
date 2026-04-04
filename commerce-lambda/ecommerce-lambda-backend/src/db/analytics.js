const db = require("./index");
const queries = require("./queries");

module.exports = {
  getRecommendations: async (customerId) => {
    const result = await db.query(queries.getRecommendations, [customerId]);
    return result.rows;
  }
};