Online sstore for homemade products using Flutter for Mobile.
This app will compile for Android and IOS. 
App features,
1. Authentication
2. Product list
3. Add/edit/remove products 
4. Product locations on a map
5. upload real product images

I have so many challenges with PWA(Progresive web App) on IOS  safari browser. Also getting access to Mobile camera is a big challenge for users to handle on PWA. 
Finally found this awesome Flutter framework that is helping me build app for any mobile users.


git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/sayedsaad07/FlutterProductsApp.git
git push -u origin master

Flutter packages 
rxDart

WidgetBindingObserver : used to control app lifecycle (backgrounded, active, inactive)
    Usage: open/close expensive connections like websocket
    How: code snippet for websocket connection 
        class mywidget extends State With WidgetBindingObserver
            initState()  --> WidgetBinding.instance.addObserver(this)
            dispose()    --> WidgetBinding.instance.removeObserver(this)
            didChangeAppLifecycleState(AppLifeCycle)
                if(AppLiofecycleState.resumed or paused or etc
                
inheritedWidget: share data with all widgets
    scoped_mode or provider state management 

Jaguar Serializer : to convert map to json
    Usage: with http request/response data. deserialize your json.decode(res.body) map into your obkect (Message object)

Fluro: routing manager 
    Usage: mage it simple to list all app routes

uri_launcher
image_picker
flutter_image: download url based on ur network speed (Network image with retry)
    Usage: slow network, this will retry to download behind the scene

async_loader: show a progressbar while waiting for async callback
    Usage: skip the isloaded flag 
        AsyncLoader _asyncLoader = new AsyncLoader(
            key: 
            initState: () async => awaity checkstatus() 
            renderLoad: () +> showprogress()
            renderError: ([error]) => showerrormessage 
            renderSuccess ({data}) => render data
        )

firebase
    firebase_core
    firebase_auth
    firebase_database
    firebase_messaging
    cloud_firestore
    

For icons
    fluitter_launcher_icons
    Canva

shared_preferences: Save data on local device
    

map_view
location



Upload image 
https://fireship.io/lessons/flutter-file-uploads-cloud-storage/

image resizing
https://fireship.io/lessons/flutter-file-uploads-cloud-storage/

Add Google functions support





