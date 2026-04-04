module.exports.success = (data) => ({
  statusCode: 200,
  body: JSON.stringify({ success: true, data })
});

module.exports.error = (message, code = 400) => ({
  statusCode: code,
  body: JSON.stringify({ success: false, message })
});