import Toybox.Graphics;
import Toybox.Lang;

class Time extends RelativeComponent {
    private var timeProvider as TimeProvider;
    private var label as $.Text;
    private var value as $.Text;
    private var showDoubleColons as Boolean = true;

    function initialize(timeProvider as TimeProvider, offset as Graphics.Point2D) {
        RelativeComponent.initialize();
        
        self.timeProvider = timeProvider;

        self.label = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_XTINY, 
            :color => Utils.Colors.greyForeground, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT,
            :text => Rez.Strings.labelTime
        });
        
        self.value = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_LARGE, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT
        });
    }

    function setOffset(offset) as Void {
        RelativeComponent.setOffset(offset);

        self.label.setOffset(offset);
        self.value.setOffset(offset);

        (new Layout.Vertical({ 
            :direction => Layout.Upwards, 
            :spacing => Utils.Sizing.spacing 
        })).apply([self.label, self.value]);
    }

    function layout(dc as Dc) as Void {
        self.label.layout(dc);
        self.value.layout(dc);
    }

    function draw(dc as Dc) as Void {
        self.showDoubleColons = !self.showDoubleColons;
        var timeFormat = self.showDoubleColons ? "$1$:$2$" : "$1$ $2$";

        var time = self.timeProvider.getText(timeFormat);

        self.value.setText(time);
        
        self.label.draw(dc);
        self.value.draw(dc);
    }
}