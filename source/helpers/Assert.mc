import Toybox.Test;
import Toybox.Lang;
import Toybox.Math;

module Assert {
    public function isEqual(expected as Object?, actual as Object?) as Void {
        if (expected == null && actual == null) {
            return;
        }

        if (expected == null || actual == null) {
            Test.assertMessage(false, "Failed asserting that " + expected + " is equal to " + actual);
        }

        Test.assertEqualMessage(expected, actual, "Failed asserting that " + expected + " is equal to " + actual);
    }

    public function arrayIsEqual(expected as Array?, actual as Array?) as Void {
        if (expected == null && actual == null) {
            return;
        }

        if (expected == null || actual == null) {
            Test.assertMessage(false, "Failed asserting that " + expected + " is equal to " + actual);
        }

        if (expected.size() != actual.size()) {
            Test.assertMessage(false, "Failed asserting that array has same size, expedted " + expected.size() + " got " + actual.size());
        }

        var isSame = true;
        for (var iX = 0; iX < expected.size(); iX++) {
            if (expected[iX] != actual[iX]) {
                isSame = false; 
                break;
            }
        }
        
        Test.assertMessage(isSame, "Failed asserting that " + expected + " is equal to " + actual);
    }


    public function isNull(actual) as Void {
        if (actual != null) {
            Test.assertMessage(false, "Expected null while given non null value");
        }
    }

    public function isNotNull(actual) as Void {
        if (actual == null) {
            Test.assertMessage(false, "Expected not to benull while given null value");
        }
    }

    public function exception(expectedCls, actual) as Void {
        if (!(actual instanceof expectedCls)) {
            Test.assertMessage(false, "Failed asserting exception instanceof of "  + expectedCls + " got " + actual);
        }
    }

    public function isApproxEqual(
        expected as Double or Float or Number,
        actual as Double or Float or Number,
        tolerance as Double or Float or Number
    ) as Void {
        if (Utils.Math.abs(expected - actual) > tolerance) {
            Test.assertMessage(false, "Failed asserting that " + expected + " is approximately equal to " + actual);
        }
    }
}