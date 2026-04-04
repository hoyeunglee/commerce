const db = require("../db");
const queries = require("../db/queries");
const { success, error } = require("../utils/response");

module.exports.handler = async (event) => {
  try {
    const { orderId } = event.pathParameters;
    const body = JSON.parse(event.body);

    const paymentId = body.payment_id;
    const actorId = body.actor_id || "system";

    await db.query(queries.markOrderPaid, [orderId, paymentId, actorId]);

    return success({ status: "PAID" });
  } catch (err) {
    return error(err.message);
  }
};