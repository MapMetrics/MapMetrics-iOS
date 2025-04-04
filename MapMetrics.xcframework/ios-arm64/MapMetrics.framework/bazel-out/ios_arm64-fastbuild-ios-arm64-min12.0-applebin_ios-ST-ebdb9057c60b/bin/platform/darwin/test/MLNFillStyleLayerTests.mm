// This file is generated.
// Edit platform/darwin/scripts/generate-style-code.js, then run `make darwin-style-code`.

#import "MLNStyleLayerTests.h"
#import "../../darwin/src/NSDate+MLNAdditions.h"

#import "MLNStyleLayer_Private.h"

#include <mbgl/style/layers/fill_layer.hpp>
#include <mbgl/style/transition_options.hpp>
#include <mbgl/style/expression/dsl.hpp>

@interface MLNFillLayerTests : MLNStyleLayerTests
@end

@implementation MLNFillLayerTests

+ (NSString *)layerType {
    return @"fill";
}

- (void)testPredicates {
    MLNPointFeature *feature = [[MLNPointFeature alloc] init];
    MLNShapeSource *source = [[MLNShapeSource alloc] initWithIdentifier:@"sourceID" shape:feature options:nil];
    MLNFillStyleLayer *layer = [[MLNFillStyleLayer alloc] initWithIdentifier:@"layerID" source:source];

    XCTAssertNil(layer.sourceLayerIdentifier);
    layer.sourceLayerIdentifier = @"layerID";
    XCTAssertEqualObjects(layer.sourceLayerIdentifier, @"layerID");
    layer.sourceLayerIdentifier = nil;
    XCTAssertNil(layer.sourceLayerIdentifier);

    XCTAssertNil(layer.predicate);
    layer.predicate = [NSPredicate predicateWithFormat:@"$featureIdentifier = 1"];
    XCTAssertEqualObjects(layer.predicate,  [NSPredicate predicateWithFormat:@"$featureIdentifier = 1"]);
    layer.predicate = nil;
    XCTAssertNil(layer.predicate);
}

- (void)testProperties {
    MLNPointFeature *feature = [[MLNPointFeature alloc] init];
    MLNShapeSource *source = [[MLNShapeSource alloc] initWithIdentifier:@"sourceID" shape:feature options:nil];

    MLNFillStyleLayer *layer = [[MLNFillStyleLayer alloc] initWithIdentifier:@"layerID" source:source];
    XCTAssertNotEqual(layer.rawLayer, nullptr);
    XCTAssertEqualObjects(@(layer.rawLayer->getTypeInfo()->type), @"fill");
    auto rawLayer = static_cast<mbgl::style::FillLayer*>(layer.rawLayer);

    MLNTransition transitionTest = MLNTransitionMake(5, 4);


    // fill-sort-key
    {
        XCTAssertTrue(rawLayer->getFillSortKey().isUndefined(),
                      @"fill-sort-key should be unset initially.");
        NSExpression *defaultExpression = layer.fillSortKey;

        NSExpression *constantExpression = [NSExpression expressionWithFormat:@"1"];
        layer.fillSortKey = constantExpression;
        mbgl::style::PropertyValue<float> propertyValue = { 1.0 };
        XCTAssertEqual(rawLayer->getFillSortKey(), propertyValue,
                       @"Setting fillSortKey to a constant value expression should update fill-sort-key.");
        XCTAssertEqualObjects(layer.fillSortKey, constantExpression,
                              @"fillSortKey should round-trip constant value expressions.");

        constantExpression = [NSExpression expressionWithFormat:@"1"];
        XCTExpectFailure(@"Awaiting unit test refactoring https://github.com/mapmetrics/mapmetrics-native/issues/421");
        NSExpression *functionExpression = [NSExpression expressionWithFormat:@"mgl_step:from:stops:($zoomLevel, %@, %@)", constantExpression, @{@18: constantExpression}];
        layer.fillSortKey = functionExpression;

        {
            using namespace mbgl::style::expression::dsl;
            propertyValue = mbgl::style::PropertyExpression<float>(
                step(zoom(), literal(1.0), 18.0, literal(1.0))
            );
        }

        XCTAssertEqual(rawLayer->getFillSortKey(), propertyValue,
                       @"Setting fillSortKey to a camera expression should update fill-sort-key.");
        XCTAssertEqualObjects(layer.fillSortKey, functionExpression,
                              @"fillSortKey should round-trip camera expressions.");

        functionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:(keyName, 'linear', nil, %@)", @{@18: constantExpression}];
        layer.fillSortKey = functionExpression;

        {
            using namespace mbgl::style::expression::dsl;
            propertyValue = mbgl::style::PropertyExpression<float>(
                interpolate(linear(), number(get("keyName")), 18.0, literal(1.0))
            );
        }

        XCTAssertEqual(rawLayer->getFillSortKey(), propertyValue,
                       @"Setting fillSortKey to a data expression should update fill-sort-key.");
        NSExpression *pedanticFunctionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:(CAST(keyName, 'NSNumber'), 'linear', nil, %@)", @{@18: constantExpression}];
        XCTAssertEqualObjects(layer.fillSortKey, pedanticFunctionExpression,
                              @"fillSortKey should round-trip data expressions.");

        functionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)", @{@10: functionExpression}];
        layer.fillSortKey = functionExpression;

        {
            using namespace mbgl::style::expression::dsl;
            propertyValue = mbgl::style::PropertyExpression<float>(
                interpolate(linear(), zoom(), 10.0, interpolate(linear(), number(get("keyName")), 18.0, literal(1.0)))
            );
        }

        XCTAssertEqual(rawLayer->getFillSortKey(), propertyValue,
                       @"Setting fillSortKey to a camera-data expression should update fill-sort-key.");
        pedanticFunctionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)", @{@10: pedanticFunctionExpression}];
        XCTAssertEqualObjects(layer.fillSortKey, pedanticFunctionExpression,
                              @"fillSortKey should round-trip camera-data expressions.");

        layer.fillSortKey = nil;
        XCTAssertTrue(rawLayer->getFillSortKey().isUndefined(),
                      @"Unsetting fillSortKey should return fill-sort-key to the default value.");
        XCTAssertEqualObjects(layer.fillSortKey, defaultExpression,
                              @"fillSortKey should return the default value after being unset.");
    }

    // fill-antialias
    {
        XCTAssertTrue(rawLayer->getFillAntialias().isUndefined(),
                      @"fill-antialias should be unset initially.");
        NSExpression *defaultExpression = layer.fillAntialiased;

        NSExpression *constantExpression = [NSExpression expressionWithFormat:@"false"];
        layer.fillAntialiased = constantExpression;
        mbgl::style::PropertyValue<bool> propertyValue = { false };
        XCTAssertEqual(rawLayer->getFillAntialias(), propertyValue,
                       @"Setting fillAntialiased to a constant value expression should update fill-antialias.");
        XCTAssertEqualObjects(layer.fillAntialiased, constantExpression,
                              @"fillAntialiased should round-trip constant value expressions.");

        constantExpression = [NSExpression expressionWithFormat:@"false"];
        XCTExpectFailure(@"Awaiting unit test refactoring https://github.com/mapmetrics/mapmetrics-native/issues/421");
        NSExpression *functionExpression = [NSExpression expressionWithFormat:@"mgl_step:from:stops:($zoomLevel, %@, %@)", constantExpression, @{@18: constantExpression}];
        layer.fillAntialiased = functionExpression;

        {
            using namespace mbgl::style::expression::dsl;
            propertyValue = mbgl::style::PropertyExpression<bool>(
                step(zoom(), literal(false), 18.0, literal(false))
            );
        }

        XCTAssertEqual(rawLayer->getFillAntialias(), propertyValue,
                       @"Setting fillAntialiased to a camera expression should update fill-antialias.");
        XCTAssertEqualObjects(layer.fillAntialiased, functionExpression,
                              @"fillAntialiased should round-trip camera expressions.");


        layer.fillAntialiased = nil;
        XCTAssertTrue(rawLayer->getFillAntialias().isUndefined(),
                      @"Unsetting fillAntialiased should return fill-antialias to the default value.");
        XCTAssertEqualObjects(layer.fillAntialiased, defaultExpression,
                              @"fillAntialiased should return the default value after being unset.");

        functionExpression = [NSExpression expressionForKeyPath:@"bogus"];
        XCTAssertThrowsSpecificNamed(layer.fillAntialiased = functionExpression, NSException, NSInvalidArgumentException, @"MLNFillLayer should raise an exception if a camera-data expression is applied to a property that does not support key paths to feature attributes.");
        functionExpression = [NSExpression expressionWithFormat:@"mgl_step:from:stops:(bogus, %@, %@)", constantExpression, @{@18: constantExpression}];
        functionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)", @{@10: functionExpression}];
        XCTAssertThrowsSpecificNamed(layer.fillAntialiased = functionExpression, NSException, NSInvalidArgumentException, @"MLNFillLayer should raise an exception if a camera-data expression is applied to a property that does not support key paths to feature attributes.");
    }

    // fill-color
    {
        XCTAssertTrue(rawLayer->getFillColor().isUndefined(),
                      @"fill-color should be unset initially.");
        NSExpression *defaultExpression = layer.fillColor;

        NSExpression *constantExpression = [NSExpression expressionWithFormat:@"%@", [MLNColor redColor]];
        layer.fillColor = constantExpression;
        mbgl::style::PropertyValue<mbgl::Color> propertyValue = { { 1, 0, 0, 1 } };
        XCTAssertEqual(rawLayer->getFillColor(), propertyValue,
                       @"Setting fillColor to a constant value expression should update fill-color.");
        XCTAssertEqualObjects(layer.fillColor, constantExpression,
                              @"fillColor should round-trip constant value expressions.");

        constantExpression = [NSExpression expressionWithFormat:@"%@", [MLNColor redColor]];
        XCTExpectFailure(@"Awaiting unit test refactoring https://github.com/mapmetrics/mapmetrics-native/issues/421");
        NSExpression *functionExpression = [NSExpression expressionWithFormat:@"mgl_step:from:stops:($zoomLevel, %@, %@)", constantExpression, @{@18: constantExpression}];
        layer.fillColor = functionExpression;

        {
            using namespace mbgl::style::expression::dsl;
            propertyValue = mbgl::style::PropertyExpression<mbgl::Color>(
                step(zoom(), literal(mbgl::Color(1, 0, 0, 1)), 18.0, literal(mbgl::Color(1, 0, 0, 1)))
            );
        }

        XCTAssertEqual(rawLayer->getFillColor(), propertyValue,
                       @"Setting fillColor to a camera expression should update fill-color.");
        XCTAssertEqualObjects(layer.fillColor, functionExpression,
                              @"fillColor should round-trip camera expressions.");

        functionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:(keyName, 'linear', nil, %@)", @{@18: constantExpression}];
        layer.fillColor = functionExpression;

        {
            using namespace mbgl::style::expression::dsl;
            propertyValue = mbgl::style::PropertyExpression<mbgl::Color>(
                interpolate(linear(), number(get("keyName")), 18.0, literal(mbgl::Color(1, 0, 0, 1)))
            );
        }

        XCTAssertEqual(rawLayer->getFillColor(), propertyValue,
                       @"Setting fillColor to a data expression should update fill-color.");
        NSExpression *pedanticFunctionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:(CAST(keyName, 'NSNumber'), 'linear', nil, %@)", @{@18: constantExpression}];
        XCTAssertEqualObjects(layer.fillColor, pedanticFunctionExpression,
                              @"fillColor should round-trip data expressions.");

        functionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)", @{@10: functionExpression}];
        layer.fillColor = functionExpression;

        {
            using namespace mbgl::style::expression::dsl;
            propertyValue = mbgl::style::PropertyExpression<mbgl::Color>(
                interpolate(linear(), zoom(), 10.0, interpolate(linear(), number(get("keyName")), 18.0, literal(mbgl::Color(1, 0, 0, 1))))
            );
        }

        XCTAssertEqual(rawLayer->getFillColor(), propertyValue,
                       @"Setting fillColor to a camera-data expression should update fill-color.");
        pedanticFunctionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)", @{@10: pedanticFunctionExpression}];
        XCTAssertEqualObjects(layer.fillColor, pedanticFunctionExpression,
                              @"fillColor should round-trip camera-data expressions.");

        layer.fillColor = nil;
        XCTAssertTrue(rawLayer->getFillColor().isUndefined(),
                      @"Unsetting fillColor should return fill-color to the default value.");
        XCTAssertEqualObjects(layer.fillColor, defaultExpression,
                              @"fillColor should return the default value after being unset.");
        // Transition property test
        layer.fillColorTransition = transitionTest;
        auto toptions = rawLayer->getFillColorTransition();
        XCTAssert(toptions.delay && MLNTimeIntervalFromDuration(*toptions.delay) == transitionTest.delay);
        XCTAssert(toptions.duration && MLNTimeIntervalFromDuration(*toptions.duration) == transitionTest.duration);

        MLNTransition fillColorTransition = layer.fillColorTransition;
        XCTAssertEqual(fillColorTransition.delay, transitionTest.delay);
        XCTAssertEqual(fillColorTransition.duration, transitionTest.duration);
    }

    // fill-opacity
    {
        XCTAssertTrue(rawLayer->getFillOpacity().isUndefined(),
                      @"fill-opacity should be unset initially.");
        NSExpression *defaultExpression = layer.fillOpacity;

        NSExpression *constantExpression = [NSExpression expressionWithFormat:@"1"];
        layer.fillOpacity = constantExpression;
        mbgl::style::PropertyValue<float> propertyValue = { 1.0 };
        XCTAssertEqual(rawLayer->getFillOpacity(), propertyValue,
                       @"Setting fillOpacity to a constant value expression should update fill-opacity.");
        XCTAssertEqualObjects(layer.fillOpacity, constantExpression,
                              @"fillOpacity should round-trip constant value expressions.");

        constantExpression = [NSExpression expressionWithFormat:@"1"];
        XCTExpectFailure(@"Awaiting unit test refactoring https://github.com/mapmetrics/mapmetrics-native/issues/421");
        NSExpression *functionExpression = [NSExpression expressionWithFormat:@"mgl_step:from:stops:($zoomLevel, %@, %@)", constantExpression, @{@18: constantExpression}];
        layer.fillOpacity = functionExpression;

        {
            using namespace mbgl::style::expression::dsl;
            propertyValue = mbgl::style::PropertyExpression<float>(
                step(zoom(), literal(1.0), 18.0, literal(1.0))
            );
        }

        XCTAssertEqual(rawLayer->getFillOpacity(), propertyValue,
                       @"Setting fillOpacity to a camera expression should update fill-opacity.");
        XCTAssertEqualObjects(layer.fillOpacity, functionExpression,
                              @"fillOpacity should round-trip camera expressions.");

        functionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:(keyName, 'linear', nil, %@)", @{@18: constantExpression}];
        layer.fillOpacity = functionExpression;

        {
            using namespace mbgl::style::expression::dsl;
            propertyValue = mbgl::style::PropertyExpression<float>(
                interpolate(linear(), number(get("keyName")), 18.0, literal(1.0))
            );
        }

        XCTAssertEqual(rawLayer->getFillOpacity(), propertyValue,
                       @"Setting fillOpacity to a data expression should update fill-opacity.");
        NSExpression *pedanticFunctionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:(CAST(keyName, 'NSNumber'), 'linear', nil, %@)", @{@18: constantExpression}];
        XCTAssertEqualObjects(layer.fillOpacity, pedanticFunctionExpression,
                              @"fillOpacity should round-trip data expressions.");

        functionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)", @{@10: functionExpression}];
        layer.fillOpacity = functionExpression;

        {
            using namespace mbgl::style::expression::dsl;
            propertyValue = mbgl::style::PropertyExpression<float>(
                interpolate(linear(), zoom(), 10.0, interpolate(linear(), number(get("keyName")), 18.0, literal(1.0)))
            );
        }

        XCTAssertEqual(rawLayer->getFillOpacity(), propertyValue,
                       @"Setting fillOpacity to a camera-data expression should update fill-opacity.");
        pedanticFunctionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)", @{@10: pedanticFunctionExpression}];
        XCTAssertEqualObjects(layer.fillOpacity, pedanticFunctionExpression,
                              @"fillOpacity should round-trip camera-data expressions.");

        layer.fillOpacity = nil;
        XCTAssertTrue(rawLayer->getFillOpacity().isUndefined(),
                      @"Unsetting fillOpacity should return fill-opacity to the default value.");
        XCTAssertEqualObjects(layer.fillOpacity, defaultExpression,
                              @"fillOpacity should return the default value after being unset.");
        // Transition property test
        layer.fillOpacityTransition = transitionTest;
        auto toptions = rawLayer->getFillOpacityTransition();
        XCTAssert(toptions.delay && MLNTimeIntervalFromDuration(*toptions.delay) == transitionTest.delay);
        XCTAssert(toptions.duration && MLNTimeIntervalFromDuration(*toptions.duration) == transitionTest.duration);

        MLNTransition fillOpacityTransition = layer.fillOpacityTransition;
        XCTAssertEqual(fillOpacityTransition.delay, transitionTest.delay);
        XCTAssertEqual(fillOpacityTransition.duration, transitionTest.duration);
    }

    // fill-outline-color
    {
        XCTAssertTrue(rawLayer->getFillOutlineColor().isUndefined(),
                      @"fill-outline-color should be unset initially.");
        NSExpression *defaultExpression = layer.fillOutlineColor;

        NSExpression *constantExpression = [NSExpression expressionWithFormat:@"%@", [MLNColor redColor]];
        layer.fillOutlineColor = constantExpression;
        mbgl::style::PropertyValue<mbgl::Color> propertyValue = { { 1, 0, 0, 1 } };
        XCTAssertEqual(rawLayer->getFillOutlineColor(), propertyValue,
                       @"Setting fillOutlineColor to a constant value expression should update fill-outline-color.");
        XCTAssertEqualObjects(layer.fillOutlineColor, constantExpression,
                              @"fillOutlineColor should round-trip constant value expressions.");

        constantExpression = [NSExpression expressionWithFormat:@"%@", [MLNColor redColor]];
        XCTExpectFailure(@"Awaiting unit test refactoring https://github.com/mapmetrics/mapmetrics-native/issues/421");
        NSExpression *functionExpression = [NSExpression expressionWithFormat:@"mgl_step:from:stops:($zoomLevel, %@, %@)", constantExpression, @{@18: constantExpression}];
        layer.fillOutlineColor = functionExpression;

        {
            using namespace mbgl::style::expression::dsl;
            propertyValue = mbgl::style::PropertyExpression<mbgl::Color>(
                step(zoom(), literal(mbgl::Color(1, 0, 0, 1)), 18.0, literal(mbgl::Color(1, 0, 0, 1)))
            );
        }

        XCTAssertEqual(rawLayer->getFillOutlineColor(), propertyValue,
                       @"Setting fillOutlineColor to a camera expression should update fill-outline-color.");
        XCTAssertEqualObjects(layer.fillOutlineColor, functionExpression,
                              @"fillOutlineColor should round-trip camera expressions.");

        functionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:(keyName, 'linear', nil, %@)", @{@18: constantExpression}];
        layer.fillOutlineColor = functionExpression;

        {
            using namespace mbgl::style::expression::dsl;
            propertyValue = mbgl::style::PropertyExpression<mbgl::Color>(
                interpolate(linear(), number(get("keyName")), 18.0, literal(mbgl::Color(1, 0, 0, 1)))
            );
        }

        XCTAssertEqual(rawLayer->getFillOutlineColor(), propertyValue,
                       @"Setting fillOutlineColor to a data expression should update fill-outline-color.");
        NSExpression *pedanticFunctionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:(CAST(keyName, 'NSNumber'), 'linear', nil, %@)", @{@18: constantExpression}];
        XCTAssertEqualObjects(layer.fillOutlineColor, pedanticFunctionExpression,
                              @"fillOutlineColor should round-trip data expressions.");

        functionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)", @{@10: functionExpression}];
        layer.fillOutlineColor = functionExpression;

        {
            using namespace mbgl::style::expression::dsl;
            propertyValue = mbgl::style::PropertyExpression<mbgl::Color>(
                interpolate(linear(), zoom(), 10.0, interpolate(linear(), number(get("keyName")), 18.0, literal(mbgl::Color(1, 0, 0, 1))))
            );
        }

        XCTAssertEqual(rawLayer->getFillOutlineColor(), propertyValue,
                       @"Setting fillOutlineColor to a camera-data expression should update fill-outline-color.");
        pedanticFunctionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)", @{@10: pedanticFunctionExpression}];
        XCTAssertEqualObjects(layer.fillOutlineColor, pedanticFunctionExpression,
                              @"fillOutlineColor should round-trip camera-data expressions.");

        layer.fillOutlineColor = nil;
        XCTAssertTrue(rawLayer->getFillOutlineColor().isUndefined(),
                      @"Unsetting fillOutlineColor should return fill-outline-color to the default value.");
        XCTAssertEqualObjects(layer.fillOutlineColor, defaultExpression,
                              @"fillOutlineColor should return the default value after being unset.");
        // Transition property test
        layer.fillOutlineColorTransition = transitionTest;
        auto toptions = rawLayer->getFillOutlineColorTransition();
        XCTAssert(toptions.delay && MLNTimeIntervalFromDuration(*toptions.delay) == transitionTest.delay);
        XCTAssert(toptions.duration && MLNTimeIntervalFromDuration(*toptions.duration) == transitionTest.duration);

        MLNTransition fillOutlineColorTransition = layer.fillOutlineColorTransition;
        XCTAssertEqual(fillOutlineColorTransition.delay, transitionTest.delay);
        XCTAssertEqual(fillOutlineColorTransition.duration, transitionTest.duration);
    }

    // fill-pattern
    {
        XCTAssertTrue(rawLayer->getFillPattern().isUndefined(),
                      @"fill-pattern should be unset initially.");
        NSExpression *defaultExpression = layer.fillPattern;

        NSExpression *constantExpression = [NSExpression expressionForConstantValue:@"Fill Pattern"];
        layer.fillPattern = constantExpression;
        mbgl::style::PropertyValue<mbgl::style::expression::Image> propertyValue = { "Fill Pattern" };
        XCTAssertEqual(rawLayer->getFillPattern(), propertyValue,
                       @"Setting fillPattern to a constant value expression should update fill-pattern.");
        XCTAssertEqualObjects(layer.fillPattern, constantExpression,
                              @"fillPattern should round-trip constant value expressions.");

        constantExpression = [NSExpression expressionWithFormat:@"MLN_FUNCTION('image', 'Fill Pattern')"];
        XCTExpectFailure(@"Awaiting unit test refactoring https://github.com/mapmetrics/mapmetrics-native/issues/421");
        NSExpression *functionExpression = [NSExpression expressionWithFormat:@"mgl_step:from:stops:($zoomLevel, %@, %@)", constantExpression, @{@18: constantExpression}];
        layer.fillPattern = functionExpression;

        {
            using namespace mbgl::style::expression::dsl;
            propertyValue = mbgl::style::PropertyExpression<mbgl::style::expression::Image>(
                step(zoom(), image(literal("Fill Pattern")), 18.0, image(literal("Fill Pattern")))
            );
        }

        XCTAssertEqual(rawLayer->getFillPattern(), propertyValue,
                       @"Setting fillPattern to a camera expression should update fill-pattern.");
        XCTAssertEqualObjects(layer.fillPattern, functionExpression,
                              @"fillPattern should round-trip camera expressions.");


        layer.fillPattern = nil;
        XCTAssertTrue(rawLayer->getFillPattern().isUndefined(),
                      @"Unsetting fillPattern should return fill-pattern to the default value.");
        XCTAssertEqualObjects(layer.fillPattern, defaultExpression,
                              @"fillPattern should return the default value after being unset.");
        // Transition property test
        layer.fillPatternTransition = transitionTest;
        auto toptions = rawLayer->getFillPatternTransition();
        XCTAssert(toptions.delay && MLNTimeIntervalFromDuration(*toptions.delay) == transitionTest.delay);
        XCTAssert(toptions.duration && MLNTimeIntervalFromDuration(*toptions.duration) == transitionTest.duration);

        MLNTransition fillPatternTransition = layer.fillPatternTransition;
        XCTAssertEqual(fillPatternTransition.delay, transitionTest.delay);
        XCTAssertEqual(fillPatternTransition.duration, transitionTest.duration);
    }

    // fill-translate
    {
        XCTAssertTrue(rawLayer->getFillTranslate().isUndefined(),
                      @"fill-translate should be unset initially.");
        NSExpression *defaultExpression = layer.fillTranslation;

        NSExpression *constantExpression = [NSExpression expressionWithFormat:@"%@",
#if TARGET_OS_IPHONE
            [NSValue valueWithCGVector:CGVectorMake(1, 1)]
#else
            [NSValue valueWithMLNVector:CGVectorMake(1, -1)]
#endif
        ];
        layer.fillTranslation = constantExpression;
        mbgl::style::PropertyValue<std::array<float, 2>> propertyValue = { { 1, 1 } };
        XCTAssertEqual(rawLayer->getFillTranslate(), propertyValue,
                       @"Setting fillTranslation to a constant value expression should update fill-translate.");
        XCTAssertEqualObjects(layer.fillTranslation, constantExpression,
                              @"fillTranslation should round-trip constant value expressions.");

        constantExpression = [NSExpression expressionWithFormat:@"{1, 1}"];
        XCTExpectFailure(@"Awaiting unit test refactoring https://github.com/mapmetrics/mapmetrics-native/issues/421");
        NSExpression *functionExpression = [NSExpression expressionWithFormat:@"mgl_step:from:stops:($zoomLevel, %@, %@)", constantExpression, @{@18: constantExpression}];
        layer.fillTranslation = functionExpression;

        {
            using namespace mbgl::style::expression::dsl;
            propertyValue = mbgl::style::PropertyExpression<std::array<float, 2>>(
                step(zoom(), literal({ 1, 1 }), 18.0, literal({ 1, 1 }))
            );
        }

        XCTAssertEqual(rawLayer->getFillTranslate(), propertyValue,
                       @"Setting fillTranslation to a camera expression should update fill-translate.");
        XCTAssertEqualObjects(layer.fillTranslation, functionExpression,
                              @"fillTranslation should round-trip camera expressions.");


        layer.fillTranslation = nil;
        XCTAssertTrue(rawLayer->getFillTranslate().isUndefined(),
                      @"Unsetting fillTranslation should return fill-translate to the default value.");
        XCTAssertEqualObjects(layer.fillTranslation, defaultExpression,
                              @"fillTranslation should return the default value after being unset.");

        functionExpression = [NSExpression expressionForKeyPath:@"bogus"];
        XCTAssertThrowsSpecificNamed(layer.fillTranslation = functionExpression, NSException, NSInvalidArgumentException, @"MLNFillLayer should raise an exception if a camera-data expression is applied to a property that does not support key paths to feature attributes.");
        functionExpression = [NSExpression expressionWithFormat:@"mgl_step:from:stops:(bogus, %@, %@)", constantExpression, @{@18: constantExpression}];
        functionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)", @{@10: functionExpression}];
        XCTAssertThrowsSpecificNamed(layer.fillTranslation = functionExpression, NSException, NSInvalidArgumentException, @"MLNFillLayer should raise an exception if a camera-data expression is applied to a property that does not support key paths to feature attributes.");
    }

    // fill-translate-anchor
    {
        XCTAssertTrue(rawLayer->getFillTranslateAnchor().isUndefined(),
                      @"fill-translate-anchor should be unset initially.");
        NSExpression *defaultExpression = layer.fillTranslationAnchor;

        NSExpression *constantExpression = [NSExpression expressionWithFormat:@"'viewport'"];
        layer.fillTranslationAnchor = constantExpression;
        mbgl::style::PropertyValue<mbgl::style::TranslateAnchorType> propertyValue = { mbgl::style::TranslateAnchorType::Viewport };
        XCTAssertEqual(rawLayer->getFillTranslateAnchor(), propertyValue,
                       @"Setting fillTranslationAnchor to a constant value expression should update fill-translate-anchor.");
        XCTAssertEqualObjects(layer.fillTranslationAnchor, constantExpression,
                              @"fillTranslationAnchor should round-trip constant value expressions.");

        constantExpression = [NSExpression expressionWithFormat:@"'viewport'"];
        XCTExpectFailure(@"Awaiting unit test refactoring https://github.com/mapmetrics/mapmetrics-native/issues/421");
        NSExpression *functionExpression = [NSExpression expressionWithFormat:@"mgl_step:from:stops:($zoomLevel, %@, %@)", constantExpression, @{@18: constantExpression}];
        layer.fillTranslationAnchor = functionExpression;

        {
            using namespace mbgl::style::expression::dsl;
            propertyValue = mbgl::style::PropertyExpression<mbgl::style::TranslateAnchorType>(
                step(zoom(), literal("viewport"), 18.0, literal("viewport"))
            );
        }

        XCTAssertEqual(rawLayer->getFillTranslateAnchor(), propertyValue,
                       @"Setting fillTranslationAnchor to a camera expression should update fill-translate-anchor.");
        XCTAssertEqualObjects(layer.fillTranslationAnchor, functionExpression,
                              @"fillTranslationAnchor should round-trip camera expressions.");


        layer.fillTranslationAnchor = nil;
        XCTAssertTrue(rawLayer->getFillTranslateAnchor().isUndefined(),
                      @"Unsetting fillTranslationAnchor should return fill-translate-anchor to the default value.");
        XCTAssertEqualObjects(layer.fillTranslationAnchor, defaultExpression,
                              @"fillTranslationAnchor should return the default value after being unset.");

        functionExpression = [NSExpression expressionForKeyPath:@"bogus"];
        XCTAssertThrowsSpecificNamed(layer.fillTranslationAnchor = functionExpression, NSException, NSInvalidArgumentException, @"MLNFillLayer should raise an exception if a camera-data expression is applied to a property that does not support key paths to feature attributes.");
        functionExpression = [NSExpression expressionWithFormat:@"mgl_step:from:stops:(bogus, %@, %@)", constantExpression, @{@18: constantExpression}];
        functionExpression = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)", @{@10: functionExpression}];
        XCTAssertThrowsSpecificNamed(layer.fillTranslationAnchor = functionExpression, NSException, NSInvalidArgumentException, @"MLNFillLayer should raise an exception if a camera-data expression is applied to a property that does not support key paths to feature attributes.");
    }
}

- (void)testPropertyNames {
    [self testPropertyName:@"fill-sort-key" isBoolean:NO];
    [self testPropertyName:@"is-fill-antialiased" isBoolean:YES];
    [self testPropertyName:@"fill-color" isBoolean:NO];
    [self testPropertyName:@"fill-opacity" isBoolean:NO];
    [self testPropertyName:@"fill-outline-color" isBoolean:NO];
    [self testPropertyName:@"fill-pattern" isBoolean:NO];
    [self testPropertyName:@"fill-translation" isBoolean:NO];
    [self testPropertyName:@"fill-translation-anchor" isBoolean:NO];
}

- (void)testValueAdditions {
    XCTAssertEqual([NSValue valueWithMLNFillTranslationAnchor:MLNFillTranslationAnchorMap].MLNFillTranslationAnchorValue, MLNFillTranslationAnchorMap);
    XCTAssertEqual([NSValue valueWithMLNFillTranslationAnchor:MLNFillTranslationAnchorViewport].MLNFillTranslationAnchorValue, MLNFillTranslationAnchorViewport);
}

@end
