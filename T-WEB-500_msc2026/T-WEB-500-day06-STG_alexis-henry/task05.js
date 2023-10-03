"use strict";

function range(start, end, step) {
  var step = step || 1;
  var result = [];
  if (step > 0) {
    for (var i = start; i <= end; i += step) {
      result.push(i);
    }
  } else {
    for (var _i = start; _i >= end; _i += step) {
      result.push(_i);
    }
  }
  return result;
}

module.exports.range = range;
