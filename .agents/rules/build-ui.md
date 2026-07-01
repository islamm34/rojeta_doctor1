---
trigger: always_on
---

seperate every component in any screen i give you in a seperated files in the widget folders of the page as stateless or stateful widget if needed

use the context extentions and screenutil like extention 

use the reusable components in the share folder with editing them if needed to fit the them of the ui 

use the the app_them.dart through the context extention after editing it for the screens of the ui to make the right colors and text style in the theme

any screen i give you if there are some static texts put them in the l10n files and use context.strings to use them 

any screen we make add the future needed endpoint in the endpoints class and the model in the models folder in the data layer without making entity in the domain layer the model will contain fromjson for the response and to json if the model will be used to request body and to formdata if needed 

any navigation will be through context.push or .pushNamed and etc... and don't forget the app_router.dart file