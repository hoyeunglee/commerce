module.exports.setCustomerContext = async (db, customerId) => {
  await db.query(`SET app.current_customer_id = $1`, [customerId]);
};