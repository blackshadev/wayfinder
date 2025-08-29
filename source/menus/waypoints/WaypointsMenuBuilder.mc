import Toybox.WatchUi;
import Toybox.Lang;

class WaypointsMenuBuilder {
	private var waypoint as WaypointsController;

	function initialize(waypoint as WaypointsController) {
		self.waypoint = waypoint;
	}

	public function build() as WatchUi.Menu2 {
		var menu = new WatchUi.Menu2({ :title => Rez.Strings.menuOpenWaypoints });

		menu.addItem(
			new MenuItem(
				Rez.Strings.menuReceiveWaypoints,
				null,
				WaypointsMenuDelegate.WAYPOINTS_RECEIVE,
				{}
			)
		);


		var noLocationLabel = null as String?;
		if (!self.waypoint.isSettable()) {
			noLocationLabel = Rez.Strings.menuSetWaypointNoLocation;
		}
		menu.addItem(
			new MenuItem(
				Rez.Strings.menuSetWaypoint,
				noLocationLabel,
				WaypointsMenuDelegate.WAYPOINT_SET,
				{}
			)
		);

		menu.addItem(
			new MenuItem(
				Rez.Strings.menuSetReturnWaypoint,
				null,
				WaypointsMenuDelegate.WAYPOINT_SET_RETURN,
				{}
			)
		);

		menu.addItem(
			new MenuItem(
				Rez.Strings.menuClearWaypoints,
				null,
				WaypointsMenuDelegate.WAYPOINTS_CLEAR,
				{}
			)
		);

		return menu;
	}
}

