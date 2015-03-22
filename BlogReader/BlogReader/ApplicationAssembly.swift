//////////////////////////////////////////////////////////////////////////////////
////
////  TYPHOON FRAMEWORK
////  Copyright 2013, Jasper Blues & Contributors
////  All Rights Reserved.
////
////  NOTICE: The authors permit you to use, modify, and distribute this file
////  in accordance with the terms of the license agreement accompanying it.
////
//////////////////////////////////////////////////////////////////////////////////
//
//public class ApplicationAssembly: TyphoonAssembly {
//    
//    //-------------------------------------------------------------------------------------------
//    // MARK: - Bootstrapping
//    //-------------------------------------------------------------------------------------------
//    
//    
//    /*
//    * These are modules - assemblies collaborate to provie components to this one.  At runtime you
//    * can instantiate Typhoon with any assembly tha satisfies the module interface.
//    */
//    var coreComponents : CoreComponents!
//    
//    
//    /*
//    * This is the definition for our AppDelegate. Typhoon will inject the specified properties
//    * at application startup.
//    */
//    public dynamic func appDelegate() -> AnyObject {
//        return TyphoonDefinition.withClass(AppDelegate.self) {
//            (definition) in
//            
//            definition.injectProperty("blogService", with:self.coreComponents.blogService())
//            definition.injectProperty("rootViewController", with:self.rootViewController())
//        }
//    }
//    
//    
//    /*
//    * A config definition, referencing properties that will be loaded from a plist.
//    */
//    public dynamic func config() -> AnyObject {
//        
//        return TyphoonDefinition.configDefinitionWithName("Configuration.plist")
//    }
//    
//    
//    //-------------------------------------------------------------------------------------------
//    // MARK: - Main Assembly
//    //-------------------------------------------------------------------------------------------
//    
//    public dynamic func rootViewController() -> AnyObject {
//        return TyphoonDefinition.withClass(RootViewController.self) {
//            (definition) in
//            
//            definition.useInitializer("initWithMastrViewController:assembly:") {
//                (initializer) in
//                
//                initializer.injectParameterWith(self.blogListController())
//                initializer.injectParameterWith(self)
//            }
//            definition.scope = TyphoonScope.Singleton
//        }
//    }
//    
//    public dynamic func blogListController() -> AnyObject {
//        
//        return TyphoonDefinition.withClass(MasterViewController.self) {
//            (definition) in
//            
//            definition.useInitializer("initWithBlogService:blogService:") {
//                (initializer) in
//                
//                initializer.injectParameterWith(self.coreComponents.blogService())
//            }
//            definition.injectProperty("assembly")
//        }
//        
//    }
//    
//    
//    public dynamic func blogDetailController() -> AnyObject {
//        
//        return TyphoonDefinition.withClass(DetailViewController.self) {
//            (definition) in
//            
//            definition.useInitializer("initWithBlogService:blogService:") {
//                (initializer) in
//                
//                initializer.injectParameterWith(self.coreComponents.blogService())
//            }
//        };
//    }
//    
//}
