import Toybox.Graphics;
import Toybox.Lang;

class MaxAverageSpeeds extends RelativeComponent {
    private var unitConverter as SettingsBoundUnitConverter;

    private var title as $.Text;
    private var maxAvg2s as $.Text;
    private var maxAvg10s as $.Text;
    private var maxAvg2sLabel as $.Text;
    private var maxAvg10sLabel as $.Text;

    function initialize(unitConverter as SettingsBoundUnitConverter, offset as Graphics.Point2D) {
        RelativeComponent.initialize();

        self.unitConverter = unitConverter;

        self.title = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_XTINY, 
            :color => Utils.Colors.greyForeground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT,
            :text => Rez.Strings.labelMaxAvgSpeed
        });
        
        self.maxAvg2s = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_GLANCE_NUMBER, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT
        });
        self.maxAvg10s = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_GLANCE_NUMBER, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT
        });

        self.maxAvg2sLabel = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Utils.Fonts.extraTinyFont(), 
            :color => Utils.Colors.greyBackground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT,
            :text => Rez.Strings.labelAvgSpeed2s
        });
        self.maxAvg10sLabel = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Utils.Fonts.extraTinyFont(), 
            :color => Utils.Colors.greyBackground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT,
            :text => Rez.Strings.labelAvgSpeed10s
        });

        self.setMaxAvgSpeeds(null);
    }

    function setOffset(offset) as Void {
        RelativeComponent.setOffset(offset);

        self.title.setOffset(offset);
        self.maxAvg2sLabel.setOffset(offset);
        self.maxAvg10sLabel.setOffset(offset);
        self.maxAvg2s.setOffset(offset);
        self.maxAvg10s.setOffset(offset);

        (new Layout.Vertical({ 
            :direction => Layout.Downwards, 
            :spacing => Utils.Sizing.spacing 
        })).apply([
            self.title,
            new Layout.Row([ self.maxAvg2s, self.maxAvg2sLabel ]),
            new Layout.Row([ self.maxAvg10s, self.maxAvg10sLabel ])
        ]);
    }

    function setMaxAvgSpeeds(value as MaxAverageSpeedValues?) as Void {
        if (value == null) {
            self.maxAvg2s.setText("--");
            self.maxAvg10s.setText("--");
            return;
        }

        var avg2s = self.unitConverter.speedFromMS(value.speed2s);
        var avg10s = self.unitConverter.speedFromMS(value.speed10s);

        self.maxAvg2s.setText(avg2s.format("%.01f"));
        self.maxAvg10s.setText(avg10s.format("%.01f"));
    }

    function layout(dc as Dc) as Void {

        self.title.layout(dc);

        self.maxAvg2sLabel.layout(dc);
        self.maxAvg10sLabel.layout(dc);

        var w = self.maxAvg10sLabel.calculateTextWidth(dc);
        self.maxAvg2s.updateOffset(self._offset[0] - w - Utils.Sizing.spacingL, null);
        self.maxAvg10s.updateOffset(self._offset[0] - w - Utils.Sizing.spacingL, null);

        self.maxAvg2s.layout(dc);
        self.maxAvg10s.layout(dc);
    }

    function draw(dc as Dc) as Void {
        self.title.draw(dc);
        
        self.maxAvg2s.draw(dc);
        self.maxAvg10s.draw(dc);

        self.maxAvg2sLabel.draw(dc);
        self.maxAvg10sLabel.draw(dc);
    }
}