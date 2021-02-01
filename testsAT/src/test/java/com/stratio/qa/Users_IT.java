package com.stratio.qa;

import com.stratio.qa.cucumber.testng.CucumberFeatureWrapper;
import com.stratio.qa.cucumber.testng.PickleEventWrapper;
import com.stratio.qa.utils.BaseGTest;
import cucumber.api.CucumberOptions;
import org.testng.annotations.Test;

@CucumberOptions(features = {
        "src/test/resources/features/users/users.feature",
}, plugin = "json:target/cucumberusers.json")
public class Users_IT extends BaseGTest {

    public Users_IT() {

    }

    @Test(enabled = true, groups = {"Users"}, dataProvider = "scenarios")
    public void runAllTestsFeatures(PickleEventWrapper pickleWrapper, CucumberFeatureWrapper featureWrapper) throws Throwable {
        runScenario(pickleWrapper, featureWrapper);
    }
}