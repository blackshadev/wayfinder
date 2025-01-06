import Toybox.Lang;
import Toybox.WatchUi;

class ExitMenuDelegate extends WatchUi.Menu2InputDelegate {
    public static const RESUME = "resume";
    public static const EXIT = "quit";
    public static const SAVE_EXIT = "save_quit";
    public static const DISCARD_EXIT = "save_quit";

    private var activity as ActivityController;

    function initialize(activity as ActivityController) {
        Menu2InputDelegate.initialize();

        self.activity = activity;
    }

    function onSelect(item as MenuItem) as Void {
        var id = item.getId() as String; 
        switch (id) {
            case SAVE_EXIT:
                self.activity.save();
                self.exit();
                break;
            case DISCARD_EXIT:
                self.activity.discard();
                self.exit();
                break;
            case EXIT:
                self.exit();
                break;
            case RESUME:
                self.onBack();
                break;
            default:
                System.println("No action for id " + id);
        }
    }

    function exit() as Void {
        self.onBack();
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}