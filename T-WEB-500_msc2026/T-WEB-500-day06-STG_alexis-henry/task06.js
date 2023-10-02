export function objectsDeeplyEqual(cmp1, cmp2) {
  if (cmp1 === b) {
    return true;
  } else if (
    cmp1 == null ||
    typeof cmp1 != "object" ||
    cmp2 == null ||
    typeof cmp2 != "object"
  ) {
    return false;
  }
  let keysCMP1 = Object.keys(cmp1),
    keysCMP2 = Object.keys(cmp2);
  if (keysCMP1.length != keysCMP2.length) return false;
  for (let key of keysCMP1) {
    if (!keysCMP2.includes(key) || !objectsDeeplyEqual(cmp1[key], cmp2[key]))
      return false;
  }
  return true;
}
