const db = require("../db");
const queries = require("../db/queries");
const { success, error } = require("../utils/response");
const { requireFields } = require("../utils/validator");

module.exports.handler = async (event) => {
  try {
    const body = JSON.parse(event.body);

    requireFields(body, [
      "customer_id",
      "order_number",
      "currency",
      "shipping_address_id",
      "billing_address_id",
      "items"
    ]);

    const result = await db.query(queries.createOrder, [
      body.customer_id,
      body.order_number,
      body.currency,
      body.shipping_address_id,
      body.billing_address_id,
      JSON.stringify(body.items)
    ]);

    return success({ order_id: result.rows[0].order_id });
  } catch (err) {
    return error(err.message);
  }
};