import Toybox.Test;
import Toybox.Lang;

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

    public function exception(expectedCls, actual) as Void {
        if (!(actual instanceof expectedCls)) {
            Test.assertMessage(false, "Failed asserting exception instanceof of "  + expectedCls + " got " + actual);
        }
    }
}