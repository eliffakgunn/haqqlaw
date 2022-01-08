import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:haqqlaw/login.dart';
import 'package:haqqlaw/register_avukat.dart';
import 'package:haqqlaw/register_muvekkil.dart';
import 'package:hexcolor/hexcolor.dart';

import 'online_danisma_muvekkil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List topic = getTopics();
    List text = getTexts();
    List image = getImages();

    return Scaffold(
      backgroundColor: HexColor("#d1dbe2"),
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text('Haqq Hukuk Ofisi'),
        backgroundColor: HexColor("#23435E"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Text(
              'Çalışma Alanlarımız',
              style: TextStyle(
                  color: HexColor("#23435E"),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: topic.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    child: Container(
                      //height: 450.0,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: 100,
                            child: Image.asset(image[index]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            //height: 600,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: Text(
                                      topic[index],
                                      style: TextStyle(
                                          color: HexColor("#23435E"),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: Container(
                                      child: Text(
                                        text[index],
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: HexColor("#23435E")),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }

  static List getImages() {
    return [
      'images/aile_hukuku.jpeg',
      'images/sigorta_hukuku.jpeg',
      'images/3.jpeg',
      'images/4.jpeg',
      'images/5.jpeg',
      'images/6.jpeg',
      'images/7.jpeg',
      'images/8.jpeg',
      'images/9.jpeg',
      'images/10.jpeg',
      'images/11.jpeg',
      'images/12.jpeg',
      'images/13.jpeg',
      'images/14.jpeg',
      'images/15.jpeg',
      'images/16.jpeg',
      'images/17.jpeg',
      'images/18.jpeg',
    ];
  }

  static List getTopics() {
    return [
      'Aile Hukuku',
      'Sigorta Hukuku',
      'Miras Hukuku',
      'İcra ve İflas Hukuku',
      'Ticaret Hukuku',
      'Bilişim Hukuku',
      'Şirketler Hukuku',
      'Fikri Mülkiyet Hukuku',
      'Gayrimenkul Hukuku',
      'Tüketici Hukuku',
      'Enerji ve Madencilik Hukuku',
      'Sağlık Hukuku',
      'Ceza Hukuku',
      'İdare Hukuku',
      'Vergi Hukuku',
      'Yabancılar ve Vatandaşlık Hukuku',
      'Göçmen Hukuku',
      'İş ve Sosyal Güvenlik Hukuku'
    ];
  }

  static List getTexts() {
    return [
      'Nişanlanma, evlenme, boşanma, velayet, vesayet gibi alt konuları kapsayan, aileye ilişkin anlaşmazlıkları çözüme kavuşturan hukuk dalıdır. Haqqlaw, aile hukukundan doğan ihtilafların mahkeme önünde çözümünde müvekkillerine Medeni Kanun, Hukuk Muhakemeleri Kanunu ve ilgili milletlerarası sözleşme ve kanunlarda yer alan hükümler çerçevesinde özel hayatın gizliliğine büyük özen ve dikkat göstererek hizmet verir.',
      'Sigorta sözleşmesi yapılan tarafların birbiriyle ilişkileri, sigortacılıkla uğraşan kurumların uyması gereken kanunları düzenleyen hukuk dalıdır. Haqqlaw, Sigorta Hukuku alanında, sigorta sözleşmesi hazırlanmasından itibaren gereksinim duyulan her türlü avukatlık ve danışmanlık hizmetini sağlamakta olup sigorta sözleşmesinden kaynaklanan tüm uyuşmazlıklarda hak ve alacak ile dava takibi yapmaktadır.',
      'Gerçek kişinin ölümü veya gaipliği durumunda, bu kişinin geride bıraktığı tüm mal varlığının kimlere ve nasıl intikal edeceğini düzenleyen hukuk dalıdır. Haqqlaw, Miras Hukuku alanında, terekenin paylaşılmasından itibaren gereksinim duyulan her türlü avukatlık ve hukuki danışmanlık hizmetini sağlamaktadır. Haqqlaw, Miras Hukuku alanında, terekenin paylaşılmasından itibaren gereksinim duyulan her türlü avukatlık ve hukuki danışmanlık hizmetini sağlamaktadır.',
      'Borçlu kişinin, borcunu zamanında ödememesi durumunda izlenecek hukuki yolları ve yaptırımları inceleyen hukuk dalıdır. Aynı zamanda alacaklı kişinin sahip olduğu haklar da bu hukuk türünde ifade edilmektedir. Haqqlaw, İcra İflas Hukuku alanıyla ilgili bilfiil hukuki danışmanlık temsiliyet hizmeti vererek alacaklı/borçlu ve üçüncü kişiler arasındaki uyuşmazlıkların çözümü için ilgili mahkemelerde dava takibi işlerini yürütmektedir.',
      'Hukukun ticaretle ilgili tüm mevzuatı kaplayan alt dalıdır. Tüccarlar, bireyler ve işletmeler arasındaki ticari ilişkileri, alışverişi ve ticari tarafların haklarını düzenler. Haqqlaw, globalleşen dünyada değişen ve gelişen ticari şartlara uygun olarak, Ticaret Hukukunun tüm bölümlerinde uyuşmazlıkların gerek yargı mercileri öncesi gerçekçi, kârlı ve kesin, gerekse yargı mercileri aracılığıyla mümkün en hızlı ve etkin çözümünde çalışmalarını yoğunlaştırmıştır.',
      'Gizlilik ve ifade özgürlüğü kapsamında internet kullanımı ile ilgili kuralları düzenleyen hukuk dalıdır. İnternet hukukunu da kapsayan bilişim hukuku, internetin kullanımındaki yasal çerçeveyi belirler. Özel hayatın gizliliği ve ifade özgürlüğü gibi kavramlar bilişim hukuku alanına girer. Haqqlaw, bilişim alanında; bilgi teknolojileri hukuku, lisanslama, muafiyetler, istisnalar, fikri mülkiyet hakları yönetimi gibi spesifik alanlarda derin ve çözüm odaklı hukuki hizmetler vermektedir.',
      'Ticaret hukuku bünyesinde yer alan ve ticaret şirketlerinin kurulması, birleşmesi, bölünmesi, devredilmesi, tip değiştirmesi, tasfiyesi gibi konulara dair normları ihtiva eden ve ticaret şirketlerine ilişkin hukuki ilişkileri inceleyen bir hukuk dalıdır. Haqqlaw, şirketler Hukuku alanında, yerli ve yabancı şirketlerin kuruluş, infisah, birleşme/devralma ve tür değiştirme işlemlerinde uzmanlaşarak müvekkillerine yasal mevzuatlara uygunluk ile ilgili her türlü hukuki danışmanlık ve temsil hizmeti sağlamaktadır.',
      'Fikir ve sanat eserleri üzerindeki düşünsel (fikri) hakları; fikir ve sanat eserleri üzerindeki hakları konu edinen hukuk dalıdır. Sınâi haklar, bütün bunların yetkilerini sahiplerinin tekeline belirli süreyle bırakan gayri maddi haklardır. Haqqlaw, globalleşen dünyada uluslararası ticaretin hızla yaygınlaşması, yerli ve yabancı firmaların kendilerine ait ürünlerin ve hizmetlerin ayırt edici karakteristik yönlerini koruması amacına uygun olarak Fikri Sınaî Haklar Hukuku alanında çeşitli işlemlerin yapılması ve bunlara dair görüşmelerin yürütülmesi hususlarında da geniş bir birikim edinmiştir ve fikri mülkiyet hukukunun Türkiye’de gelişmesine katkı sağlamaktadır.',
      'Gayrimenkul hukuku bireyler veya kurumlar arasındaki arazi, arsa, ev, daire, apartman vb. taşınmaz mallarla ilgili mevzuatları kapsayan bir hukuk dalıdır. Tapu, istihkak, kira, kamulaştırma davaları ile kamulaştırmasız el atma davaları gayrimenkul hukukunun başlıca konularındandır. Haqqlaw, gayrimenkul proje gelişimi konusunda uzmanlaşmış; mülkiyet sahiplerine ve yatırımcılara, mülkiyetin devri ve yönetimi konularında danışmanlık hizmeti vermenin yanı sıra emlak alım satımı, kiralama, ayni ya da şahsi hak tesisi gibi çeşitli işlemlerin yapılması ve bunlara dair görüşmelerin yürütülmesi hususlarında da geniş bir birikim edinmiştir.',
      'Tüketicilerin ekonomik çıkarlarının yanı sıra sağlığını ve güvenliğini korumak adına ve yine tüketicinin zararlarını karşılamak, bunu da yasal çerçeve doğrultusunda gerçekleştirmek adına düzenlemelerde bulunan hukuk dalıdır. Haqqlaw, tüketici hukuku alanında yaşanmakta olan her türlü sorun ile ilgili tüm sektörlerde tüketicinin korunması hakkında ilgili yönetmelikler alanına giren konuların, Tüketici Hakem Heyeti ve Tüketici Mahkemelerinde görülen ihtilaflı hususların çözümünde hizmet vermektedir.',
      'Enerji kaynaklarının çıkarılması, kullanımı, üretimi, tüketimi ile ilgili kanunların oluşturduğu hukuk dalıdır. Sektördeki başlıca iştigal konuları olarak enerji santralleri, petrol, gaz ve maden sıralanabilmektedir. Haqqlaw, elektrik, rüzgar, doğal gaz, güneş enerjisi yanı sıra biokütle, bioyakıt gibi yenilenebilir enerji alanlarında üretim, dağıtım ve finansman konularında danışmanlık hizmeti ile enerji sektöründeki sözleşmeler konusunda hukuki danışman olarak hizmet vermektedir.',
      'Sağlık hizmeti sunan gerçek ve tüzel kişileri denetleyen, bu kişilerle hasta ve devlet arasında sunumla ilgili ortaya çıkan hukuki sorunları tespit ve çözüm önerileri içeren hukuk dalıdır. Örneğin, hekimler, tıbbi müdahaleleri sırasında kurallara uymaz ve gerekli dikkat, özeni göstermezlerse; bu sorumluluklara göre ortaya çıkan zarardan sorumlu tutulurlar. Haqqlaw, Gerek yerel gerekse uluslararası müvekkillere hizmet vererek Sağlık ve İlaç hukukundan kaynaklanan uyuşmazlıklar, hasta-hekim yükümlülükleri ile sektörel faaliyetlerden doğan tüm uyuşmazlıkların çözümü ile ilgili hizmet vermektedir.',
      'Suçu, suçlu ve mağdur kapsamında inceleyerek kamu düzeninin tesisi için kanuni yaptırımların uygulandığı hukuk dalıdır. Haqqlaw, soruşturma ve dava öncesinden soruşturma ve davaların yürütülmesi ile infaz aşamasına kadar, cezai yaptırım riski olan tüm iş ve işlemlere ilişkin müvekkillerine soruşturma aşamasından itibaren gereksinim duyulan her türlü avukatlık ve danışmanlık hizmetini sağlamaktadır.',
      'Temeli anayasada belirlenen, idarenin faaliyet ve örgütlenmesine ilişkin kurallar öngören, kamuya tanınan üstünlük ve ayrıcalıklar ile bireye tanınan hak ve hürriyetlerin dengelenmesini sağlayan hukuk dalıdır. Haqqlaw, müvekkillerinin çeşitli idareler ile uyuşmazlıklarının çözümü ve giderilmesi hususunda kamuya tanınan ayrıcalıklarla vatandaşların sahip olduğu hak ve hürriyetleri adil bir şekilde yürütmeye çalışarak müvekkillerine her türlü avukatlık ve danışmanlık hizmetini sağlamaktadır.',
      'Vergi hukuku, kamu hukuku içinde yer alan ve devletin mali faaliyetlerinin hukuki yönünü inceleyen mali hukukun bir alt dalıdır. Vergiye tabi bireyleri, toplanan vergileri, vergiye dair tüm unsurları kapsamaktadır. Vergi hukuku, devletin kamu gücüne dayanarak elde ettiği kamu gelirlerinin hukuki rejimini inceler. Haqqlaw, müvekkillerine Gelir Vergisi Kanunu, Kurumlar Vergisi Kanunu ile Vergi Usül Kanunu ile diğer yasal mevzuattan kaynaklanan tüm vergi ihtilaflarının çözümü ve giderilmesi hususunda her türlü avukatlık ve danışmanlık hizmetini sağlamaktadır.',
      'Bir devletin veya ülkenin bir ülkeye gelen yabancılar için uyguladığı kanunların oluşturduğu hukuk dalıdır. Yabancılar hukuku genel anlamda mütekabiliyet ilkesine dayanmakta olup, yabancılara Türkiyede uygulanacak olan hukuk kuralları yabancının vatandaşı olduğu ülkeye göre farklılık göstermektedir. Haqqlaw, hukuki misyonu ışığında, yabancılar için uygulanan kanunlar ile milletlerarası antlaşmalarla tespit edilen hakların uygulanmasını takip ederek yerli ve yabancı gerçek ve tüzel kişi müvekkillerimize hukuki danışmanlık hizmetleri sağlamaktadır.',
      'Bir göçün gerçekleşmesi sonucu; mülteci, göçmen, sığınmacı, geçici koruma gibi hukuki statülerinde olan bireyler için Türkiye’nin taraf olduğu Uluslararası Göç Hukuku’ndan kaynaklanan antlaşmaların uygulanması için yapılan kanunların oluşturduğu hukuk dalıdır. Haqqlaw, Uluslararası ekonomik göçün makro dinamiklerinin belirlendiği son çeyrek asılda göç veren ülke konumundan göç alan ülke konumuna geçmekte olan Türkiye gibi bir ülkede faaliyet göstermekte olan Hukuk Bürosu ile , donanımlı Avukat ve Yabancı Danışmalarımız aracılığıyla göçmen hukuku alanında bilfiil hukuki danışmanlık vermektedir.',
      'Bireylerin iş yaşamlarını işçi, işveren ve devlet yönleriyle ele alan ve bireylerin sosyal refahını etkileyecek riskleri önleme ve sosyal güvenliği sağlama amacını taşıyan bir hukuk dalıdır. Haqqlaw, müvekkillerinin insan kaynakları birimleri ile sürekli iletişim halinde çalışarak, istihdam sürecinin başladığı andan sona erdiği ana kadar bütün prosedürün yasal düzenlemelere uygun yerine getirilmesini sağlamakta ve gerekli görüldüğü durumlarda müvekkil uygulamasının mevzuata uygunluğu için yeniden tanzim edilmesine destek vermektedir.',
    ];
  }
}

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Container(
                  alignment: Alignment.center,
                  height: 150,
                  width: 250,
                  child: Image.asset("images/amblem.jpeg"),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: HexColor("#23435E"),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.message_outlined,
              color: HexColor("#23435E"),
            ),
            title: Text(
              "Online Danışma",
              style: TextStyle(color: HexColor("#23435E")),
            ),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => OnlineDanismaMuvekkil()))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person_add_alt_1_outlined,
              color: HexColor("#23435E"),
            ),
            title: Text(
              "Müvekkil Kayıt",
              style: TextStyle(color: HexColor("#23435E")),
            ),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => RegisterMuvekkil()))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person_add_alt_1_outlined,
              color: HexColor("#23435E"),
            ),
            title: Text(
              "Avukat Kayıt",
              style: TextStyle(color: HexColor("#23435E")),
            ),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => RegisterAvukat()))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.login,
              color: HexColor("#23435E"),
            ),
            title: Text(
              "Oturum Aç",
              style: TextStyle(color: HexColor("#23435E")),
            ),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Login()))
            },
          ),
        ],
      ),
    );
  }
}
