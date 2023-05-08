// main.dart
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Oraciones Catholicas básicas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Home page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Animation controller
  late AnimationController _animationController;

  // This is used to animate the icon of the main FAB
  late Animation<double> _buttonAnimatedIcon;

  // This is used for the child FABs
  late Animation<double> _translateButton;

  // This variable determnies whether the child FABs are visible or not
  bool _isExpanded = false;

  @override
  initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..addListener(() {
        setState(() {});
      });

    _buttonAnimatedIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _translateButton = Tween<double>(
      begin: 100,
      end: -20,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  // dispose the animation controller
  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // This function is used to expand/collapse the children floating buttons
  // It will be called when the primary FAB (with menu icon) is pressed
  _toggle() {
    if (_isExpanded) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    _isExpanded = !_isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oraciones Catholicas básicas'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(
              Icons.info_rounded,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
                    .copyWith(topRight: Radius.circular(0))),
            padding: EdgeInsets.all(10),
            elevation: 10,
            onSelected: (value) {
              if (value == 'Choice._privacypolicy') {
                _privacypolicy();
                print('[home.dart] _privacypolicy()');
              } else if (value == 'Choice._share') {
                Share.share('En la tienda de aplicacion https://example.com',
                    subject: 'Aplicacion oraciones catolica básicas');
                print('[home.dart] _share()');
              } else {}
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    padding: EdgeInsets.only(right: 50, left: 20),
                    value: 'Choice._privacypolicy',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.privacy_tip_rounded,
                              size: 20,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Política de privacidad',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    )),
                PopupMenuItem(
                    padding: EdgeInsets.only(right: 50, left: 20),
                    value: 'Choice._share',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.share,
                              size: 20,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Compartir',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    )),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                'Assets/images/nutsisnitin-1574320526796-cathopic.jpg',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                  ''
                  ''
                  'Para leer las oraciones oprima el menu',
                  style: TextStyle(
                      color: Colors.white,
                      background: Paint()..color = Colors.lightBlue.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                )),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 4,
              0.0,
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: _pageviewthird,
              child: const Text('3'),
            ),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0,
              _translateButton.value * 3,
              0,
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: _pageviewsecond,
              child: const Text('2'),
            ),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0,
              _translateButton.value * 2,
              0,
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: _opennewpage,
              child: const Text('1'),
            ),
          ),
          // This is the primary FAB
          FloatingActionButton(
            onPressed: _toggle,
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _buttonAnimatedIcon,
            ),
          ),
        ],
      ),
    );
  }

  void _opennewpage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Pagina 1'),
            ),
            body: SingleChildScrollView(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Text('''
              
    Padre Nuestro
              
              ''',
                      maxLines: 20,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Image.asset(
                    'Assets/images/cathopic_148454590852713.jpg',
                    height: 200,
                    width: 400,
                    fit: BoxFit.fitWidth,
                  ),
                  new Text(
                    '''
                  
Padre nuestro, 
que estás en el cielo, 
santificado sea tu Nombre;
venga a nosotros tu reino; 
hágase tu voluntad
en la tierra como en el cielo. 
Danos hoy nuestro pan de cada día;
perdona nuestras ofensas,
como también nosotros
perdonamos a los que nos ofenden;
no nos dejes caer en la tentación, 
y líbranos del mal.
                       
Amén.
                ''',
                    maxLines: 20,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  new Text('''
                  
              
    Dios te salve María
              
              ''',
                      maxLines: 50,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),

                  Image.asset(
                    'Assets/images/cathopic_1544742283795270.jpg',
                    height: 200,
                    width: 400,
                    fit: BoxFit.fitWidth,
                  ),
                  new Text('''
                  
  Dios te salve María
  llena eres de gracia, el Señor es contigo;
  bendita tú eres entre todas las mujeres,
  y bendito es el fruto de tu vientre, Jesús.
                          
  Santa María, Madre de Dios,
  ruega por nosotros,los pecadores,
  ahora y en la ahora de nuestra muerte
                          
  Amén.
                ''',
                      maxLines: 50,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),

                  new Text('''
                  
              
   Gloria al Padre
              
              ''',
                      maxLines: 50,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),

                  Image.asset(
                    'Assets/images/cathopic_148778873340500.jpg',
                    height: 200,
                    width: 400,
                    fit: BoxFit.fitWidth,
                  ),
                  ////Image.network('https://i.swncdn.com/media/400w/cms/CCOM/60643-catholic-priest-communion-thinkstockphotos-88.1200w.tn.jpg'),
                  new Text('''
                  
  Gloria al Padre,
  y al Hijo,
  y al Espíritu Santo.
  Como era en el principio,
  ahora y siempre, por los siglos de los siglos.

  Amén
                ''',
                      maxLines: 50,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),

                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.lightBlue,
                        width: 5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                          " Regresa al la primera pagina para leer las otras oraciones",
                          style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _pageviewsecond() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Pagina 2'),
            ),
            body: SingleChildScrollView(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Text('''
                  
              
   Credo
              
              ''',
                      maxLines: 50,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Image.asset('Assets/images/cathopic_1521568181227473.jpg'),
                  new Text('''
                    
  Creo en un solo Señor, Jesucristo,
  Hijo único de Dios, nacido del Padre antes de todos los siglos:
  Dios de Dios, Luz de Luz, Dios verdadero de Dios verdadero,
  engendrado, no creado, de la misma naturaleza del Padre,
  por quien todo fue hecho;
  que por nosotros lo hombres,
  y por nuestra salvación bajó del cielo,
  y por obra del Espíritu Santo se encarnó de María, la Virgen,
  y se hizo hombre;
  y por nuestra causa fue crucificado
  en tiempos de Poncio Pilato;
  padeció y fue sepultado,
  y resucitó al tercer día, según las Escrituras,
  y subió al cielo,
  y está sentado a la derecha del Padre;
  y de nuevo vendrá con gloria
  para juzgar a vivos y muertos,
  y su reino no tendrá fin.

  Creo en el Espíritu Santo,
  Señor y dador de vida,
  que procede del Padre y del Hijo,
  que con el Padre y el Hijo
  recibe una misma adoración y gloria,
  y que habló por los profetas.

  Creo en la Iglesia, que es una, santa, católica y apostólica.
  Confieso que hay un solo bautismo
  para el perdón de los pecados.
  Espero la resurrección de los muertos
  y la vida del mundo futuro.

  Amén.
  
  
                    ''',
                      maxLines: 50,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  new Text('''
                  
              
   Salve
              
              ''',
                      maxLines: 50,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Image.asset(
                      'Assets/images/mario_sdb-1564458703747-cathopic.jpg'),
                  new Text('''            
                         
  Dios te salve,
  Reina y Madre de misericordia,
  vida, dulzura y esperanza nuestra.
  Dios te salve.
  A Tí clamamos los desterrados hijos de Eva,
  a Tí suspiramos, gimiendo y llorando en este valle de lágrimas.
  Ea, pues, Señora Abogada Nuestra,
  vuelve a nosotros tus ojos misericordiosos,
  y después de este destierro, muéstranos a Jesús,
  fruto bendito de tu vientre.
  Oh, clemente, oh piadosa,
  oh dulce Virgen María.
  Ruega por nosotros, Santa Madre de Dios,
  para que seamos dignos de alcanzar las promesas
  de Nuestro Señor Jesucristo.

  Amén
  
                    ''',
                      maxLines: 50,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  new Text('''
                  
              
   Angel de la Guarda
              
              ''',
                      maxLines: 50,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Image.asset(
                      'Assets/images/tachodimas-1559494568976-cathopic.jpg'),
                  new Text('''
                    
  Ángel de mi guarda dulce compañía
  no me desampares ni de noche ni de día.
  No me dejes sólo que sin ti me perdería.
  Hasta que me entregues en los brazos
  de Jesus y de Maria

  Amén
                    ''',
                      maxLines: 50,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.lightBlue,
                        width: 5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                          " Regresa al la primera pagina para leer las otras oraciones",
                          style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _pageviewthird() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Pagina 3'),
            ),
            body: SingleChildScrollView(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Text('''
                  
              
   Yo confieso

              
              ''',
                      maxLines: 50,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Image.asset(
                      'Assets/images/vytas_sdb-1569046036181-cathopic.jpg'),
                  new Text('''
                    
  Yo confieso ante Dios Todopoderoso,
  y ante ustedes hermanos
  que he pecado mucho de pensamiento,
  palabra, obra y omisión.
  Por mi culpa, por mi culpa, por mi gran culpa.
  Por eso ruego a Santa María siempre Virgen,
  a los ángeles, a los santos y a ustedes hermanos,
  que intercedan por mí ante Dios, Nuestro Señor.

  Amén.
  
  
                    ''',
                      maxLines: 50,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  new Text('''
                  
              
   Acto de Contrición
              
              ''',
                      maxLines: 50,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Image.asset('Assets/images/acto-de-contrición.jpg'),
                  new Text('''            
                         
  Señor mío, Jesucristo,
  Dios y hombre verdadero,
  me pesa de todo corazón haberte ofendido;
  propongo firmemente nunca más pecar,
  apartarme de todas las ocasiones de pecado,
  confesarme y cumplir la penitencia.
  Confío que por tu infinita misericordia
  me has de conceder el perdón de mis culpas
  y me has de llevar a la vida eterna.
  Te ofrezco, Señor, mi vida,
  obras y trabajos en satisfacción de todos mis pecados.


  Amén.
  
                    ''',
                      maxLines: 50,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.lightBlue,
                        width: 5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                          " Regresa al la primera pagina para leer las otras oraciones",
                          style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _privacypolicy() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Políticas de Privacidad'),
            ),
            body: SingleChildScrollView(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Text('''
                  
              
  PRIVACY POLICY FOR MOBILE APPLICATIONS

              
              ''',
                      maxLines: 50,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  new Text(
                    '''
                    
      This privacy policy governs your use of the software application for mobile devices that was created by John Rua


   What information does the Application obtain and how is it used?
   
Automatically Collected Information In addition, the Application may collect certain information automatically, including, but not limited to, the type of mobile device you use, your mobile devices unique device ID, the IP address of your mobile device, your mobile operating system, the type of mobile Internet browsers you use, and information about the way you use the Application.
   
  Does the Application collect precise real time location information of the device?

This Application does not collect precise information about the location of your mobile device.
   
   Do third parties see and/or have access to information obtained by the Application?

Only aggregated, anonymized data is periodically transmitted to external services to help us improve the Application and our service. We will share your information with third parties only in the ways that are described in this privacy statement.
   
   We may disclose User Provided and Automatically Collected Information:
   
  As required by law, such as to comply with a subpoena, or similar legal process; when we believe in good faith that disclosure is necessary to protect our rights, protect your safety or the safety of others, investigate fraud, or respond to a government request; with our trusted services providers who work on our behalf, do not have an independent use of the information we disclose to them, and have agreed to adhere to the rules set forth in this privacy statement.
      
      
      What are my opt-out rights?
      
 You can stop all collection of information by the Application easily by uninstalling the Application. You may use the standard uninstall processes as may be available as part of your mobile device or via the mobile application marketplace or network. Data Retention Policy, Managing Your Information We will retain User Provided data for as long as you use the Application and for a reasonable time thereafter. We will retain Automatically Collected information for up to 24 months and thereafter may store it in aggregate. If you’d like us to delete User Provided Data that you have provided via the Application, please contact us at (tu email) and we will respond in a reasonable time. Please note that some or all of the User Provided Data may be required in order for the Application to function properly. 
  
  Children 
      
 We do not use the Application to knowingly solicit data from or market to children under the age of 13. If a parent or guardian becomes aware that his or her child has provided us with information without their consent, he or she should contact us at afrfreelancer@gmail.com  . We will delete such information from our files within a reasonable time. 
 
  Security 
      
We are concerned about safeguarding the confidentiality of your information. We provide physical, electronic, and procedural safeguards to protect information we process and maintain. For example, we limit access to this information to authorized employees and contractors who need to know that information in order to operate, develop or improve our Application. Please be aware that, although we endeavor provide reasonable security for information we process and maintain, no security system can prevent all potential security breaches.

  Changes
      
This Privacy Policy may be updated from time to time for any reason. We will notify you of any changes to our Privacy Policy by posting the new Privacy Policy here and informing you via email or text message. You are advised to consult this Privacy Policy regularly for any changes, as continued use is deemed approval of all changes. You can check the history of this policy by clicking here.
Your Consent By using the Application, you are consenting to our processing of your information as set forth in this Privacy Policy now and as amended by us. “Processing,” means using cookies on a computer/hand held device or using or touching information in any way, including, but not limited to, collecting, storing, deleting, using, combining and disclosing information, all of which activities will take place in the cloud. 
      
  Contact us
  
If you have any questions regarding privacy while using the Application, or have questions about our practices, please contact us via email at Jrua89@gmail.com
      
  Extended policy concerning the application of the European GDPR.

In accordance with the obligations of the Regulation (EU) 2016/679 of the European Parliament and of the Council of 27 April 2016 on the protection of natural persons with regard to the processing of personal data and on the free movement of such data, and repealing Directive 95/46/EC (General Data Protection Regulation) (Text with EEA relevance)

Data processor


John rua does not own any of the client data stored or processed via the service gold.appybuilder.com

John Rua is not responsible for the content of the personal data contained in the client data or other information stored on its servers.

At the discretion of the client or user nor is John rua responsible for the manner in which the client or user collects, handles disclosure, distributes or otherwise processes such information.
Contact to access, correct, delete any data information

gold.appybuilder.com

Your choices

Access, Correction, Deletion
 
We respect your privacy rights and provide you with reasonable access to the Personal Data that you may have provided through your use of the Services.
If you wish to access or amend any other Personal Data we hold about you or to request that we delete any information about you that we have obtained from an Integrated Service, you may contact us.
At your request we will have any reference to you deleted or blocked in our database.
You may update, correct, or delete your Account information and preferences at any time by accessing your Account settings page on the Service.
Please note that while any changes you make will be reflected in active user databases instantly or within a reasonable period of time, we may retain all information you submit for backups, archiving, prevention of fraud and abuse, analytic, satisfaction of legal obligations, or where we otherwise reasonably believe that we have a legitimate reason to do so
You may decline to share certain personal data with us, in which case we may not be able to provide to you some of the features and functionality of the Service.
At any time, you may object to the processing of your personal data, on legitimate grounds except if otherwise permitted by applicable law.
Intended use of personal data

Unless you want to use advanced features in applications, we do not require any form of registration, allowing you to use the application without telling us who you are.
However some services do require you to provide us with personal data.
In these situations, if you choose to withhold any personal data request by us, it may not not be possible for you to gain access to certain parts of the application and for us to respond to your query.


How we use the information we collect
 
 
We use the information that we collect in a variety of ways in providing the service and operating our business.
Including the following operations:
- Maintain, enhance and provide all features of the service, to provide the services and information that you request,
to respond to comments and questions and to provide support to users of the service we process client data solely in accordance with the directions provided by the applicable client or user improvements.
- We may use a visitor or user email address or other information other than client data to contact that visitor or user for administrative purposes such as customer service,
to address intellectual property infringement, right of privacy violations or defamation issues related to the client data or personal data posted on the service.
  
  
                    ''',
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    textWidthBasis: TextWidthBasis.longestLine,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
        );
      },
    );
  }
}
