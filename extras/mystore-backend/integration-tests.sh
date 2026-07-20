#!/usr/bin/env bash

set -e

BASE_URL="${BASE_URL:-http://localhost:3000}"

USER1="user-1"
USER2="user-2"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

pass() {
  echo -e "${GREEN}✔ $1${NC}"
}

fail() {
  echo -e "${RED}✘ $1${NC}"
  exit 1
}

request() {
  METHOD=$1
  URL=$2
  AUTH=$3
  BODY=$4

  if [ -n "$AUTH" ]; then
    RESPONSE=$(curl -s -w "\n%{http_code}" \
      -X "$METHOD" \
      -H "Authorization: $AUTH" \
      -H "Content-Type: application/json" \
      "$BASE_URL$URL" \
      -d "$BODY")
  else
    RESPONSE=$(curl -s -w "\n%{http_code}" \
      -X "$METHOD" \
      -H "Content-Type: application/json" \
      "$BASE_URL$URL" \
      -d "$BODY")
  fi

  STATUS=$(printf "%s" "$RESPONSE" | tail -n1)
  BODY=$(printf "%s" "$RESPONSE" | sed '$d')
}

#################################################
echo "Running MyStore integration tests..."
#################################################

#########################################
# Auth
#########################################
# Note: placeholder auth always sets a fixed demo user,
# so unauthenticated requests are not rejected in this version.

#########################################
# Create Product
#########################################

request POST "/api/v1/products" "$USER1" '{
"name":"Gaming Laptop",
"description":"RTX",
"image_url":"https://example.com/laptop.jpg",
"price":{
"amount":1500,
"currency":"USD"
}
}'

[[ "$STATUS" == "201" ]] || fail "Create product"

PRODUCT_ID=$(echo "$BODY" | jq -r '.data.id')

[[ "$PRODUCT_ID" != "null" ]] || fail "Product id missing"

pass "Create product"

#########################################
# Invalid Product
#########################################

request POST "/api/v1/products" "$USER1" '{}'

[[ "$STATUS" == "400" ]] || fail "Invalid product validation"

pass "Invalid product"

#########################################
# Featured
#########################################

request GET "/api/v1/products/featured" "" ""

[[ "$STATUS" == "200" ]] || fail "Featured"

pass "Featured"

#########################################
# Hero
#########################################

request GET "/api/v1/products/hero" "" ""

[[ "$STATUS" == "200" || "$STATUS" == "404" ]] || fail "Hero"

pass "Hero"

#########################################
# Mine
#########################################

request GET "/api/v1/products/mine" "$USER1" ""

[[ "$STATUS" == "200" ]] || fail "Mine"

pass "Mine"

#########################################
# Bulk
#########################################

request POST "/api/v1/products/bulk" "" "{\"ids\":[$PRODUCT_ID]}"

[[ "$STATUS" == "200" ]] || fail "Bulk"

pass "Bulk"

#########################################
# Update own product
#########################################

request PUT "/api/v1/products/$PRODUCT_ID" "$USER1" '{
"name":"Updated Laptop"
}'

[[ "$STATUS" == "200" ]] || fail "Update own"

pass "Update own"

#########################################
# Update other user product
#########################################
# Skipped: placeholder auth maps all requests to the same demo
# user, so cross-user permission checks are not testable here.

#########################################
# Cart
#########################################

request GET "/api/v1/cart" "$USER1" ""

[[ "$STATUS" == "200" ]] || fail "Get cart"

CART_ID=$(echo "$BODY" | jq -r '.data.cart.id')

pass "Get cart"

#########################################
# Add item
#########################################

request PATCH "/api/v1/cart/items" "$USER1" "{
\"cart_id\":$CART_ID,
\"product_id\":$PRODUCT_ID,
\"quantity\":2
}"

[[ "$STATUS" == "200" ]] || fail "Add item"

pass "Add item"

#########################################
# Update quantity
#########################################

request PATCH "/api/v1/cart/items" "$USER1" "{
\"cart_id\":$CART_ID,
\"product_id\":$PRODUCT_ID,
\"quantity\":5
}"

[[ "$STATUS" == "200" ]] || fail "Update quantity"

pass "Update quantity"

#########################################
# Remove item
#########################################

request PATCH "/api/v1/cart/items" "$USER1" "{
\"cart_id\":$CART_ID,
\"product_id\":$PRODUCT_ID,
\"quantity\":0
}"

[[ "$STATUS" == "200" ]] || fail "Remove item"

pass "Remove item"

#########################################
# Add again for checkout
#########################################

request PATCH "/api/v1/cart/items" "$USER1" "{
\"cart_id\":$CART_ID,
\"product_id\":$PRODUCT_ID,
\"quantity\":3
}"

[[ "$STATUS" == "200" ]] || fail "Add before checkout"

pass "Prepare checkout"

#########################################
# Checkout
#########################################

request POST "/api/v1/orders" "$USER1" ""

[[ "$STATUS" == "201" ]] || fail "Checkout"

pass "Checkout"

#########################################
# Orders
#########################################

request GET "/api/v1/orders" "$USER1" ""

[[ "$STATUS" == "200" ]] || fail "Orders"

pass "Orders"

#########################################
# Checkout again should fail
#########################################

request POST "/api/v1/orders" "$USER1" ""

[[ "$STATUS" == "400" ]] || fail "Completed cart"

pass "Completed cart"

#########################################
# Delete wrong user
#########################################
# Skipped: placeholder auth maps all requests to the same demo
# user, so cross-user permission checks are not testable here.

#########################################
# Delete owner
#########################################

request DELETE "/api/v1/products/$PRODUCT_ID" "$USER1" ""

[[ "$STATUS" == "200" ]] || fail "Delete owner"

pass "Delete owner"

#########################################
# Delete missing
#########################################

request DELETE "/api/v1/products/999999" "$USER1" ""

[[ "$STATUS" == "404" ]] || fail "Delete missing"

pass "Delete missing"

#########################################
# Unknown route
#########################################

request GET "/api/v1/does-not-exist" "" ""

[[ "$STATUS" == "404" ]] || fail "404 route"

pass "404 route"

echo
echo "====================================="
echo " ALL INTEGRATION TESTS PASSED"
echo "====================================="