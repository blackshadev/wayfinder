import Toybox.WatchUi;

class ActivityMenuBuilder {
    private var activity as ActivityController;

    function initialize(activity as ActivityController) {
        self.activity = activity;
    }

    public function build() as WatchUi.Menu2 {
        var menu = new WatchUi.Menu2({
            :title => WatchUi.loadResource(Rez.Strings.activityMenuTitle)
        });

        if (self.activity.isPaused()) {
            menu.addItem(
                new MenuItem(
                    WatchUi.loadResource(Rez.Strings.activityMenuResume),
                    null,
                    ActivityMenuDelegate.ACTIVITY_RESUME,
                    {}
                )
            );
        } else {
           menu.addItem(
                new MenuItem(
                    WatchUi.loadResource(Rez.Strings.activityMenuPause),
                    null,
                    ActivityMenuDelegate.ACTIVITY_PAUSE,
                    {}
                )
            ); 
        }
        
        menu.addItem(
            new MenuItem(
                WatchUi.loadResource(Rez.Strings.activityMenuSave),
                null,
                ActivityMenuDelegate.ACTIVITY_SAVE,
                {}
            )
        );

        menu.addItem(
            new MenuItem(
                WatchUi.loadResource(Rez.Strings.activityMenuDiscard),
                null,
                ActivityMenuDelegate.ACTIVITY_DISCARD,
                {}
            )
        ); 

        return menu;
    }
}