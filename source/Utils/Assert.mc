import Toybox.Test;
import Toybox.Lang;

module Assert {
    public function isEqual(logger as Logger, expected, actual) as Boolean {
        if (actual != expected) {
            logger.error("Failed asserting that " + expected + " is equal to " + actual);
            return false;
        }

        return true;
    }

    public function expectedException(logger as Logger) as Boolean {
        logger.error("Expected exception but got none");
        return false;
    }

    public function all(all as Array<Boolean>) as Boolean {
        for (var i = 0; i < all.size(); i++) {
            if (all[i] == false) {
                return false;
            }
        }

        return true;
    }
}