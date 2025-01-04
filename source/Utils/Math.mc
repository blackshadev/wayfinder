import Toybox.Lang;

module Utils {
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
}