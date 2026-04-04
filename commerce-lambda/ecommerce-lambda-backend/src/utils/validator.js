module.exports.requireFields = (obj, fields) => {
  for (const f of fields) {
    if (!obj[f]) throw new Error(`Missing field: ${f}`);
  }
};