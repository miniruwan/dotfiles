#!/bin/bash

# ---------- Helper functions -----------
print_debug() {
  # Printing message in the console.
  BLUE='\e[94m'
  NC='\033[0m' # No Color
  echo ""
  echo -e "${BLUE}$1${NC}"
}

print_info() {
  # Printing message in the console.
  GREEN_BLINK_BOLD='\e[5m\e[32m\e[1m'
  NC='\033[0m' # No Color
  echo ""
  echo "------------------------------"
  echo -e "${GREEN_BLINK_BOLD}$1${NC}"
  echo "------------------------------"
}

print_important() {
  # Printing message in the console.
  RED='\033[0;31m'
  NC='\033[0m' # No Color
  echo ""
  echo "------------------------------------- NOTICE -----------------------------------------"
  echo -e "${RED}$1${NC}"
  echo "--------------------------------------------------------------------------------------"
}
