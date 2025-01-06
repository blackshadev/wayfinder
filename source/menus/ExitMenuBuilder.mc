import Toybox.WatchUi;
import Toybox.Lang;

class ExitMenuBuilder {
    private var activity as ActivityController;

    function initialize(activity as ActivityController) {
        self.activity = activity;
    }

    public function build() as WatchUi.Menu2 {
        var menu = new WatchUi.Menu2({ :title => WatchUi.loadResource(Rez.Strings.exitMenuTitle) });

        menu.addItem(
            new MenuItem(
                WatchUi.loadResource(Rez.Strings.exitMenuResume),
                null,
                ExitMenuDelegate.RESUME,
                {}
            )
        );
        
        if (self.activity.isStarted()) {
            menu.addItem(
                new MenuItem(
                    WatchUi.loadResource(Rez.Strings.exitMenuSaveExit),
                    null,
                    ExitMenuDelegate.SAVE_EXIT,
                    {}
                )
            );

            menu.addItem(
                new MenuItem(
                    WatchUi.loadResource(Rez.Strings.exitMenuDiscardExit),
                    null,
                    ExitMenuDelegate.DISCARD_EXIT,
                    {}
                )
            );
        
        } else {
            menu.addItem(
                new MenuItem(
                    WatchUi.loadResource(Rez.Strings.exitMenuExit),
                    null,
                    ExitMenuDelegate.EXIT,
                    {}
                )
            );
        }


        return menu;
    }
}