import Toybox.Graphics;
import Toybox.Lang;

class MaxSpeeds extends RelativeComponent {
    private var title as $.Text;

    private var max2s as $.Text;
    private var max10s as $.Text;

    private var max2sLabel as $.Text;
    private var max10sLabel as $.Text;
    private var microFont as Graphics.VectorFont;

    function initialize(offset as Graphics.Point2D) {
        RelativeComponent.initialize();

        self.title = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_XTINY, 
            :color => Graphics.COLOR_LT_GRAY, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT,
            :text => "Max"
        });
        
        self.max2s = new $.Text({
            :offset => [offset[0] + 35, offset[1]], 
            :font => Graphics.FONT_GLANCE_NUMBER, 
            :color => Graphics.COLOR_WHITE, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT
        });
        self.max10s = new $.Text({
            :offset => [offset[0] + 35, offset[1]], 
            :font => Graphics.FONT_GLANCE_NUMBER, 
            :color => Graphics.COLOR_WHITE, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT
        });

        self.microFont = Utils.getFont(
            ["NotoSans", "RobotoRegular", "RobotoCondensed"],
            20,
            Graphics.FONT_XTINY
        );
        self.max2sLabel = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => self.microFont, 
            :color => Graphics.COLOR_DK_GRAY, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT,
            :text => " 2s"
        });
        self.max10sLabel = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => self.microFont, 
            :color => Graphics.COLOR_DK_GRAY, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT,
            :text => "10s"
        });

        (new Layout.Vertical({ 
            :direction => Layout.Downwards, 
            :spacing => Utils.Sizing.spacing 
        })).apply([
            self.title,
            new Layout.Row([self.max2s, self.max2sLabel]),
            new Layout.Row([self.max10s, self.max10sLabel]),
        ]);

        self.setValue(null);
    }

    function setOffset(offset) as Void {
        RelativeComponent.setOffset(offset);

        self.title.setOffset(offset);
        self.max2sLabel.setOffset(offset);
        self.max10sLabel.setOffset(offset);
        self.max2s.setOffset(offset);
        self.max10s.setOffset(offset);

        (new Layout.Vertical({ 
            :direction => Layout.Downwards, 
            :spacing => Utils.Sizing.spacing 
        })).apply([
            self.title,
            new Layout.Row([ self.max2sLabel, self.max2s ]),
            new Layout.Row([ self.max10sLabel, self.max10s ])
        ]);
    }

    function setValue(value as MaxSpeedValues?) as Void {
        if (value == null) {
            self.max2s.setText("--");
            self.max10s.setText("--");
            return;
        }

        self.max2s.setText(value.speed2sKMPH().format("%.01f"));
        self.max10s.setText(value.speed10sKMPH().format("%.01f"));
    }

    function layout(dc as Dc) as Void {

        self.title.layout(dc);

        self.max2sLabel.layout(dc);
        self.max10sLabel.layout(dc);

        var w = self.max10sLabel.calculateTextWidth(dc);
        self.max2s.updateOffset(self._offset[0] + w + Utils.Sizing.spacingL, null);
        self.max10s.updateOffset(self._offset[0] + w + Utils.Sizing.spacingL, null);

        self.max2s.layout(dc);
        self.max10s.layout(dc);
    }

    function draw(dc as Dc) as Void {
        self.title.draw(dc);
        
        self.max2s.draw(dc);
        self.max10s.draw(dc);

        self.max2sLabel.draw(dc);
        self.max10sLabel.draw(dc);
    }
}