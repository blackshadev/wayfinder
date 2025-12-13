import Toybox.Lang;

module Utils {
    module Math {
        public function min(a as Numeric, b as Numeric) as Numeric {
            if (a > b) {
                return b;
            }
            return a;
        }

        public function max(a as Numeric, b as Numeric) as Numeric {
            if (a > b) {
                return a;
            }
            return b;
        }

        public function abs(value as Numeric) as Numeric {
            if (value < 0) {
                return -value;
            }
            return value;
        }
    }

    module Angles {
        public function subtract(a as Number, b as Number) as Number {
            return (a - b + 360) % 360;
        }
    }
}