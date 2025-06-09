import Toybox.Graphics;
import Toybox.Lang;

class MaxAverageSpeeds2 extends RelativeComponent {
    private var unitConverter as SettingsBoundUnitConverter;

    private var maxAvg30m as $.Text;
    private var maxAvg30mLabel as $.Text;
    private var maxAvg60m as $.Text;
    private var maxAvg60mLabel as $.Text;
    private var topOffset as Layout.Offset;

    function initialize(unitConverter as SettingsBoundUnitConverter, offset as Graphics.Point2D) {
        RelativeComponent.initialize();

        self.unitConverter = unitConverter;

        self.topOffset = new Layout.Offset({
            :offset => [offset[0], offset[1]],
            :size => [0, Utils.Fonts.getFontHeight(Graphics.FONT_XTINY)]
        });
        self.maxAvg30m = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_GLANCE_NUMBER, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT
        });
        self.maxAvg60m = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_GLANCE_NUMBER, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT
        });

        self.maxAvg30mLabel = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Utils.Fonts.extraTinyFont(), 
            :color => Utils.Colors.greyBackground, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT,
            :text => Rez.Strings.labelAvgSpeed30m
        });
        self.maxAvg60mLabel = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Utils.Fonts.extraTinyFont(), 
            :color => Utils.Colors.greyBackground, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT,
            :text => Rez.Strings.labelAvgSpeed60m
        });

        self.setMaxAvgSpeeds(null);
    }

    function setOffset(offset) as Void {
        RelativeComponent.setOffset(offset);

        self.topOffset.setOffset(offset);
        self.maxAvg30mLabel.setOffset(offset);
        self.maxAvg30m.setOffset(offset);
        self.maxAvg60mLabel.setOffset(offset);
        self.maxAvg60m.setOffset(offset);

        (new Layout.Vertical({ 
            :direction => Layout.Downwards, 
            :spacing => Utils.Sizing.spacing 
        })).apply([
            self.topOffset,
            new Layout.Row([ self.maxAvg30mLabel, self.maxAvg30m ]),
            new Layout.Row([ self.maxAvg60mLabel, self.maxAvg60m ])
        ]);
    }

    function setMaxAvgSpeeds(speeds as MaxAverageSpeedValues?) as Void {
        if (speeds == null) {
            self.maxAvg30m.setText("--");
            self.maxAvg60m.setText("--");
            return;
        }

        var maxAvg30m = self.unitConverter.speedFromMS(speeds.speed30m);
        self.maxAvg30m.setText(maxAvg30m.format("%.01f"));

        var maxAvg60m = self.unitConverter.speedFromMS(speeds.speed60m);
        self.maxAvg60m.setText(maxAvg60m.format("%.01f"));
    }


    function layout(dc as Dc) as Void {
        self.maxAvg30mLabel.layout(dc);
        self.maxAvg60mLabel.layout(dc);

        var w = self.maxAvg60mLabel.calculateTextWidth(dc);
        self.maxAvg30m.updateOffset(self._offset[0] + w + Utils.Sizing.spacingL, null);
        self.maxAvg60m.updateOffset(self._offset[0] + w + Utils.Sizing.spacingL, null);

        self.maxAvg30m.layout(dc);
        self.maxAvg60m.layout(dc);
    }

    function draw(dc as Dc) as Void {
        self.maxAvg30m.draw(dc);
        self.maxAvg60m.draw(dc);

        self.maxAvg30mLabel.draw(dc);
        self.maxAvg60mLabel.draw(dc);
    }
}