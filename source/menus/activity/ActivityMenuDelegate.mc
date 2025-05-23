import Toybox.WatchUi;
import Toybox.Lang;

class ActivityMenuDelegate extends WatchUi.Menu2InputDelegate {
    public static const ACTIVITY_START = "activity_start";
    public static const ACTIVITY_PAUSE = "activity_pause";
    public static const ACTIVITY_RESUME = "activity_resume";
    public static const ACTIVITY_DISCARD = "activity_discard";
    public static const ACTIVITY_SAVE = "activity_save";
    public static const ACTIVITY_NOTHING = "activity_nothing";

    private var activity as ActivityController;

    function initialize(activity as ActivityController) {
        Menu2InputDelegate.initialize();

        self.activity = activity;
    }

    function onSelect(item as MenuItem) as Void {
        var id = item.getId() as String; 

        switch (id) { 
            case ACTIVITY_START:
                self.activity.start();
                break;
            case ACTIVITY_PAUSE:
                self.activity.pause();
                break;
            case ACTIVITY_RESUME:
                self.activity.resume();
                break;
            case ACTIVITY_DISCARD:
                self.activity.discard();
                break;
            case ACTIVITY_SAVE:
                self.activity.save();
                break;
            case ACTIVITY_NOTHING:
                break;
        }

        WatchUi.requestUpdate();
        WatchUi.popView(WatchUi.SLIDE_LEFT);
    }

    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_LEFT);
    }
}