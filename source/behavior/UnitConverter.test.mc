
import Toybox.Test;
import Toybox.Lang;

(:test)
function testSpeedFromMStoMS(logger as Logger) as Boolean {
    var converter = new UnitConverter(new FakeSettingsController(SettingsController.UNITS_DISTANCE_METERS, SettingsController.UNITS_SPEED_MS));


    return Assert.all([
        Assert.isEqual(logger, null, converter.speedFromMS(null)),
        Assert.isEqual(logger, 0.0, converter.speedFromMS(0.0)),
        Assert.isEqual(logger, 100.0, converter.speedFromMS(100.0))
    ]);
}

(:test)
function testSpeedFromMStoKMH(logger as Logger) as Boolean {
    var converter = new UnitConverter(new FakeSettingsController(SettingsController.UNITS_DISTANCE_METERS, SettingsController.UNITS_SPEED_KMH));

    return Assert.all([
        Assert.isEqual(logger, null, converter.speedFromMS(null)),
        Assert.isEqual(logger, 0.0, converter.speedFromMS(0.0)),
        Assert.isEqual(logger, 360.0, converter.speedFromMS(100.0))
    ]);    
}

(:test)
function testSpeedFromMStoMPS(logger as Logger) as Boolean {
    var converter = new UnitConverter(new FakeSettingsController(SettingsController.UNITS_DISTANCE_METERS, SettingsController.UNITS_SPEED_MPH));

    return Assert.all([
        Assert.isEqual(logger, null, converter.speedFromMS(null)),
        Assert.isEqual(logger, 0.0, converter.speedFromMS(0.0)),
        Assert.isEqual(logger, 223.693634, converter.speedFromMS(100.0))
    ]);
}

(:test)
function testSpeedFromMStoKnots(logger as Logger) as Boolean {
    var converter = new UnitConverter(new FakeSettingsController(SettingsController.UNITS_DISTANCE_METERS, SettingsController.UNITS_SPEED_KNOTS));

    return Assert.all([
        Assert.isEqual(logger, null, converter.speedFromMS(null)),
        Assert.isEqual(logger, 0.0, converter.speedFromMS(0.0)),
        Assert.isEqual(logger, 194.384445, converter.speedFromMS(100.0))
    ]);
}


(:test)
function testSpeedFromMStoUnknown(logger as Logger) as Boolean {
    var converter = new UnitConverter(new FakeSettingsController(SettingsController.UNITS_DISTANCE_METERS, SettingsController.UNITS_SPEED_DONOTUSE_UPPER_LIMIT));


    if (!Assert.isEqual(logger, null, converter.speedFromMS(null))) {
        return false;
    }

    try {
        converter.speedFromMS(100.0);

        return Assert.expectedException(logger);
    } catch(e) {}

    return true;
}
