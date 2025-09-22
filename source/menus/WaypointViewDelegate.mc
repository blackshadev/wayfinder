import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class WaypointViewDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onBack()  as Boolean {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
        return true;
    }

}