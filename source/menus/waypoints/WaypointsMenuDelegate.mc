import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class WaypointsMenuDelegate extends WatchUi.Menu2InputDelegate {
	public static const WAYPOINTS_RECEIVE = "waypoints_receive";
	public static const WAYPOINT_SET = "waypoint_set";
	public static const WAYPOINT_SET_RETURN = "waypoint_set_return";
	public static const WAYPOINTS_CLEAR = "waypoints_clear";

	private var waypoints as WaypointsController;
	private var receiver as WaypointServerRetriever;

	function initialize(
        waypoints as WaypointsController,
        receiver as WaypointServerRetriever
    ) {
		Menu2InputDelegate.initialize();
		self.waypoints = waypoints;
		self.receiver = receiver;
	}

	function onSelect(item as MenuItem) as Void {
		var id = item.getId() as String;

		switch (id) {
			case WAYPOINTS_RECEIVE:
				self.openReceiveWaypoints();
				return;
			case WAYPOINT_SET:
				self.setWaypoint();
				self.backToMainView();
				return;
			case WAYPOINT_SET_RETURN:
				self.setReturnWaypoint();
				self.backToMainView();
				return;
			case WAYPOINTS_CLEAR:
				self.clearWaypoints();
				self.backToMainView();
				return;
			default:
				System.println("No action for id " + id);
		}
	}

	function onBack() as Void {
		WatchUi.popView(WatchUi.SLIDE_RIGHT);
	}

	private function openReceiveWaypoints() as Void {
		// Close the menu, then switch to the ReceiveWaypoints view via ViewController
		self.backToMainView();

		self.receiver.reset();
        var view = new ReceiveWaypointsView(self.receiver);
        WatchUi.pushView(view, new WaypointViewDelegate(), WatchUi.SLIDE_LEFT);
	}

	private function setWaypoint() as Void {
		if (!self.waypoints.isSettable()) {
			return;
		}
		self.waypoints.setWaypoint();
	}

	private function setReturnWaypoint() as Void {
		if (!self.waypoints.isSettable()) {
			return;
		}
		self.waypoints.setReturn();
	}

	private function clearWaypoints() as Void {
		self.waypoints.clear();
	}

	private function backToMainView() as Void {
		WatchUi.popView(WatchUi.SLIDE_RIGHT);
		WatchUi.popView(WatchUi.SLIDE_RIGHT);
	}
}

