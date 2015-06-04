//
//  JLSConfTest.m
//  Julius
//
//  Created by Tetsuro Higuchi on 6/4/15.
//  Copyright (c) 2015 Tetsuro Higuchi. All rights reserved.
//

#import "SpecHelper.h"
#import "JLSConf.h"

SpecBegin(JLSConfSpecs)


describe(@"defaultConfig", ^{

    it(@"can do maths", ^{
        JLSConf *conf = [JLSConf defaultConfig];
        expect(1).beLessThan(23);
    });
    
    it(@"can read", ^{
        expect(@"team").toNot.contain(@"I");
    });
});

SpecEnd
