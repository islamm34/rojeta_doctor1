import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';

enum EgyptGovernorate {
  cairo('cairo'),
  giza('giza'),
  alexandria('alexandria'),
  dakahlia('dakahlia'),
  sharqia('sharqia'),
  gharbia('gharbia'),
  qalyubia('qalyubia'),
  monufia('monufia'),
  beheira('beheira'),
  damietta('damietta'),
  portSaid('port_said'),
  ismailia('ismailia'),
  suez('suez'),
  kafrElSheikh('kafr_el_sheikh'),
  fayoum('fayoum'),
  beniSuef('beni_suef'),
  minya('minya'),
  asyut('asyut'),
  sohag('sohag'),
  qena('qena'),
  luxor('luxor'),
  aswan('aswan'),
  redSea('red_sea'),
  southSinai('south_sinai'),
  northSinai('north_sinai'),
  matrouh('matrouh'),
  newValley('new_valley');

  final String value;
  const EgyptGovernorate(this.value);

  String localizedName(BuildContext context) {
    switch (this) {
      case EgyptGovernorate.cairo:
        return context.strings.govCairo;
      case EgyptGovernorate.giza:
        return context.strings.govGiza;
      case EgyptGovernorate.alexandria:
        return context.strings.govAlexandria;
      case EgyptGovernorate.dakahlia:
        return context.strings.govDakahlia;
      case EgyptGovernorate.sharqia:
        return context.strings.govSharqia;
      case EgyptGovernorate.gharbia:
        return context.strings.govGharbia;
      case EgyptGovernorate.qalyubia:
        return context.strings.govQalyubia;
      case EgyptGovernorate.monufia:
        return context.strings.govMonufia;
      case EgyptGovernorate.beheira:
        return context.strings.govBeheira;
      case EgyptGovernorate.damietta:
        return context.strings.govDamietta;
      case EgyptGovernorate.portSaid:
        return context.strings.govPortSaid;
      case EgyptGovernorate.ismailia:
        return context.strings.govIsmailia;
      case EgyptGovernorate.suez:
        return context.strings.govSuez;
      case EgyptGovernorate.kafrElSheikh:
        return context.strings.govKafrElSheikh;
      case EgyptGovernorate.fayoum:
        return context.strings.govFayoum;
      case EgyptGovernorate.beniSuef:
        return context.strings.govBeniSuef;
      case EgyptGovernorate.minya:
        return context.strings.govMinya;
      case EgyptGovernorate.asyut:
        return context.strings.govAsyut;
      case EgyptGovernorate.sohag:
        return context.strings.govSohag;
      case EgyptGovernorate.qena:
        return context.strings.govQena;
      case EgyptGovernorate.luxor:
        return context.strings.govLuxor;
      case EgyptGovernorate.aswan:
        return context.strings.govAswan;
      case EgyptGovernorate.redSea:
        return context.strings.govRedSea;
      case EgyptGovernorate.southSinai:
        return context.strings.govSouthSinai;
      case EgyptGovernorate.northSinai:
        return context.strings.govNorthSinai;
      case EgyptGovernorate.matrouh:
        return context.strings.govMatrouh;
      case EgyptGovernorate.newValley:
        return context.strings.govNewValley;
    }
  }

  static EgyptGovernorate? fromString(String? val, {BuildContext? context}) {
    if (val == null || val.trim().isEmpty) return null;
    final normalized = val.trim().toLowerCase();
    for (final gov in EgyptGovernorate.values) {
      if (gov.value.toLowerCase() == normalized ||
          gov.name.toLowerCase() == normalized) {
        return gov;
      }
      if (context != null &&
          gov.localizedName(context).toLowerCase() == normalized) {
        return gov;
      }
    }
    return null;
  }

  static String localizedNameFromValue(BuildContext context, String? val) {
    if (val == null || val.isEmpty) return '';
    final gov = EgyptGovernorate.fromString(val, context: context);
    return gov != null ? gov.localizedName(context) : val;
  }

  List<EgyptCity> get cities =>
      EgyptCity.values.where((c) => c.governorate == this).toList();
}

enum EgyptCity {
  cairoNasrCity('cairo_nasr_city', EgyptGovernorate.cairo),
  cairoHeliopolis('cairo_heliopolis', EgyptGovernorate.cairo),
  cairoMaadi('cairo_maadi', EgyptGovernorate.cairo),
  cairoNewCairo('cairo_new_cairo', EgyptGovernorate.cairo),
  cairoDowntown('cairo_downtown', EgyptGovernorate.cairo),
  cairoShubra('cairo_shubra', EgyptGovernorate.cairo),
  cairoZamalek('cairo_zamalek', EgyptGovernorate.cairo),
  cairoMokattam('cairo_mokattam', EgyptGovernorate.cairo),
  cairoRehab('cairo_rehab', EgyptGovernorate.cairo),
  cairoMadinaty('cairo_madinaty', EgyptGovernorate.cairo),
  cairoElShorouk('cairo_el_shorouk', EgyptGovernorate.cairo),
  cairoBadrCity('cairo_badr_city', EgyptGovernorate.cairo),
  cairoHelwan('cairo_helwan', EgyptGovernorate.cairo),
  cairoAinShams('cairo_ain_shams', EgyptGovernorate.cairo),
  cairoElZaytoun('cairo_el_zaytoun', EgyptGovernorate.cairo),
  gizaDokki('giza_dokki', EgyptGovernorate.giza),
  gizaMohandessin('giza_mohandessin', EgyptGovernorate.giza),
  gizaOctober6th('giza_october_6th', EgyptGovernorate.giza),
  gizaSheikhZayed('giza_sheikh_zayed', EgyptGovernorate.giza),
  gizaHaram('giza_haram', EgyptGovernorate.giza),
  gizaFaisal('giza_faisal', EgyptGovernorate.giza),
  gizaAgouza('giza_agouza', EgyptGovernorate.giza),
  gizaImbaba('giza_imbaba', EgyptGovernorate.giza),
  gizaOmrania('giza_omrania', EgyptGovernorate.giza),
  gizaHawamdia('giza_hawamdia', EgyptGovernorate.giza),
  alexandriaSmouha('alexandria_smouha', EgyptGovernorate.alexandria),
  alexandriaSidiGaber('alexandria_sidi_gaber', EgyptGovernorate.alexandria),
  alexandriaGleem('alexandria_gleem', EgyptGovernorate.alexandria),
  alexandriaStanley('alexandria_stanley', EgyptGovernorate.alexandria),
  alexandriaRoushdy('alexandria_roushdy', EgyptGovernorate.alexandria),
  alexandriaMiami('alexandria_miami', EgyptGovernorate.alexandria),
  alexandriaMandara('alexandria_mandara', EgyptGovernorate.alexandria),
  alexandriaMontazah('alexandria_montazah', EgyptGovernorate.alexandria),
  alexandriaLoran('alexandria_loran', EgyptGovernorate.alexandria),
  alexandriaSanStefano('alexandria_san_stefano', EgyptGovernorate.alexandria),
  alexandriaAgami('alexandria_agami', EgyptGovernorate.alexandria),
  alexandriaBorgElArab('alexandria_borg_el_arab', EgyptGovernorate.alexandria),
  dakahliaMansoura('dakahlia_mansoura', EgyptGovernorate.dakahlia),
  dakahliaTalkha('dakahlia_talkha', EgyptGovernorate.dakahlia),
  dakahliaMitGhamr('dakahlia_mit_ghamr', EgyptGovernorate.dakahlia),
  dakahliaDikirnis('dakahlia_dikirnis', EgyptGovernorate.dakahlia),
  dakahliaSenbellawein('dakahlia_senbellawein', EgyptGovernorate.dakahlia),
  dakahliaBelqas('dakahlia_belqas', EgyptGovernorate.dakahlia),
  sharqiaZagazig('sharqia_zagazig', EgyptGovernorate.sharqia),
  sharqiaRamadan10th('sharqia_ramadan_10th', EgyptGovernorate.sharqia),
  sharqiaBelbeis('sharqia_belbeis', EgyptGovernorate.sharqia),
  sharqiaMinyaElQamh('sharqia_minya_el_qamh', EgyptGovernorate.sharqia),
  sharqiaFaqous('sharqia_faqous', EgyptGovernorate.sharqia),
  gharbiaTanta('gharbia_tanta', EgyptGovernorate.gharbia),
  gharbiaMahalla('gharbia_mahalla', EgyptGovernorate.gharbia),
  gharbiaZifta('gharbia_zifta', EgyptGovernorate.gharbia),
  gharbiaKafrElZayat('gharbia_kafr_el_zayat', EgyptGovernorate.gharbia),
  qalyubiaBanha('qalyubia_banha', EgyptGovernorate.qalyubia),
  qalyubiaShubraElKheima('qalyubia_shubra_el_kheima', EgyptGovernorate.qalyubia),
  qalyubiaObour('qalyubia_obour', EgyptGovernorate.qalyubia),
  qalyubiaQalyub('qalyubia_qalyub', EgyptGovernorate.qalyubia),
  qalyubiaKhanka('qalyubia_khanka', EgyptGovernorate.qalyubia),
  monufiaShibinElKom('monufia_shibin_el_kom', EgyptGovernorate.monufia),
  monufiaMenouf('monufia_menouf', EgyptGovernorate.monufia),
  monufiaAshmoun('monufia_ashmoun', EgyptGovernorate.monufia),
  monufiaSadatCity('monufia_sadat_city', EgyptGovernorate.monufia),
  monufiaQuesna('monufia_quesna', EgyptGovernorate.monufia),
  beheiraDamanhour('beheira_damanhour', EgyptGovernorate.beheira),
  beheiraKafrElDawwar('beheira_kafr_el_dawwar', EgyptGovernorate.beheira),
  beheiraRosetta('beheira_rosetta', EgyptGovernorate.beheira),
  beheiraEdko('beheira_edko', EgyptGovernorate.beheira),
  damiettaDamiettaCity('damietta_damietta_city', EgyptGovernorate.damietta),
  damiettaNewDamietta('damietta_new_damietta', EgyptGovernorate.damietta),
  damiettaRasElBar('damietta_ras_el_bar', EgyptGovernorate.damietta),
  damiettaFaraskur('damietta_faraskur', EgyptGovernorate.damietta),
  portSaidPortSaidCity('port_said_port_said_city', EgyptGovernorate.portSaid),
  portSaidPortFouad('port_said_port_fouad', EgyptGovernorate.portSaid),
  portSaidElArab('port_said_el_arab', EgyptGovernorate.portSaid),
  portSaidElZohour('port_said_el_zohour', EgyptGovernorate.portSaid),
  ismailiaIsmailiaCity('ismailia_ismailia_city', EgyptGovernorate.ismailia),
  ismailiaFayed('ismailia_fayed', EgyptGovernorate.ismailia),
  ismailiaQantara('ismailia_qantara', EgyptGovernorate.ismailia),
  suezSuezCity('suez_suez_city', EgyptGovernorate.suez),
  suezElArbaeen('suez_el_arbaeen', EgyptGovernorate.suez),
  suezAttaka('suez_attaka', EgyptGovernorate.suez),
  kafrElSheikhKafrElSheikhCity('kafr_el_sheikh_kafr_el_sheikh_city', EgyptGovernorate.kafrElSheikh),
  kafrElSheikhDesouk('kafr_el_sheikh_desouk', EgyptGovernorate.kafrElSheikh),
  kafrElSheikhBaltim('kafr_el_sheikh_baltim', EgyptGovernorate.kafrElSheikh),
  fayoumFayoumCity('fayoum_fayoum_city', EgyptGovernorate.fayoum),
  fayoumSenuris('fayoum_senuris', EgyptGovernorate.fayoum),
  fayoumIbshaway('fayoum_ibshaway', EgyptGovernorate.fayoum),
  beniSuefBeniSuefCity('beni_suef_beni_suef_city', EgyptGovernorate.beniSuef),
  beniSuefNewBeniSuef('beni_suef_new_beni_suef', EgyptGovernorate.beniSuef),
  beniSuefElWasti('beni_suef_el_wasti', EgyptGovernorate.beniSuef),
  minyaMinyaCity('minya_minya_city', EgyptGovernorate.minya),
  minyaNewMinya('minya_new_minya', EgyptGovernorate.minya),
  minyaMallawi('minya_mallawi', EgyptGovernorate.minya),
  minyaSamalut('minya_samalut', EgyptGovernorate.minya),
  asyutAsyutCity('asyut_asyut_city', EgyptGovernorate.asyut),
  asyutNewAsyut('asyut_new_asyut', EgyptGovernorate.asyut),
  asyutDairut('asyut_dairut', EgyptGovernorate.asyut),
  asyutManfalut('asyut_manfalut', EgyptGovernorate.asyut),
  sohagSohagCity('sohag_sohag_city', EgyptGovernorate.sohag),
  sohagNewSohag('sohag_new_sohag', EgyptGovernorate.sohag),
  sohagAkhmim('sohag_akhmim', EgyptGovernorate.sohag),
  sohagGirga('sohag_girga', EgyptGovernorate.sohag),
  sohagTahta('sohag_tahta', EgyptGovernorate.sohag),
  qenaQenaCity('qena_qena_city', EgyptGovernorate.qena),
  qenaNagHammadi('qena_nag_hammadi', EgyptGovernorate.qena),
  qenaQus('qena_qus', EgyptGovernorate.qena),
  luxorLuxorCity('luxor_luxor_city', EgyptGovernorate.luxor),
  luxorEsna('luxor_esna', EgyptGovernorate.luxor),
  luxorArmant('luxor_armant', EgyptGovernorate.luxor),
  aswanAswanCity('aswan_aswan_city', EgyptGovernorate.aswan),
  aswanNewAswan('aswan_new_aswan', EgyptGovernorate.aswan),
  aswanKomOmbo('aswan_kom_ombo', EgyptGovernorate.aswan),
  aswanEdfu('aswan_edfu', EgyptGovernorate.aswan),
  redSeaHurghada('red_sea_hurghada', EgyptGovernorate.redSea),
  redSeaGouna('red_sea_gouna', EgyptGovernorate.redSea),
  redSeaSafaga('red_sea_safaga', EgyptGovernorate.redSea),
  redSeaMarsaAlam('red_sea_marsa_alam', EgyptGovernorate.redSea),
  southSinaiSharmElSheikh('south_sinai_sharm_el_sheikh', EgyptGovernorate.southSinai),
  southSinaiDahab('south_sinai_dahab', EgyptGovernorate.southSinai),
  southSinaiNuweiba('south_sinai_nuweiba', EgyptGovernorate.southSinai),
  southSinaiRasSedr('south_sinai_ras_sedr', EgyptGovernorate.southSinai),
  northSinaiArish('north_sinai_arish', EgyptGovernorate.northSinai),
  northSinaiSheikhZuweid('north_sinai_sheikh_zuweid', EgyptGovernorate.northSinai),
  northSinaiBirElAbd('north_sinai_bir_el_abd', EgyptGovernorate.northSinai),
  matrouhMarsaMatrouh('matrouh_marsa_matrouh', EgyptGovernorate.matrouh),
  matrouhAlamein('matrouh_alamein', EgyptGovernorate.matrouh),
  matrouhDabaa('matrouh_dabaa', EgyptGovernorate.matrouh),
  matrouhSiwa('matrouh_siwa', EgyptGovernorate.matrouh),
  newValleyKharga('new_valley_kharga', EgyptGovernorate.newValley),
  newValleyDakhla('new_valley_dakhla', EgyptGovernorate.newValley),
  newValleyFarafra('new_valley_farafra', EgyptGovernorate.newValley);

  final String value;
  final EgyptGovernorate governorate;
  const EgyptCity(this.value, this.governorate);

  String localizedName(BuildContext context) {
    switch (this) {
      case EgyptCity.cairoNasrCity:
        return context.strings.cityCairoNasrCity;
      case EgyptCity.cairoHeliopolis:
        return context.strings.cityCairoHeliopolis;
      case EgyptCity.cairoMaadi:
        return context.strings.cityCairoMaadi;
      case EgyptCity.cairoNewCairo:
        return context.strings.cityCairoNewCairo;
      case EgyptCity.cairoDowntown:
        return context.strings.cityCairoDowntown;
      case EgyptCity.cairoShubra:
        return context.strings.cityCairoShubra;
      case EgyptCity.cairoZamalek:
        return context.strings.cityCairoZamalek;
      case EgyptCity.cairoMokattam:
        return context.strings.cityCairoMokattam;
      case EgyptCity.cairoRehab:
        return context.strings.cityCairoRehab;
      case EgyptCity.cairoMadinaty:
        return context.strings.cityCairoMadinaty;
      case EgyptCity.cairoElShorouk:
        return context.strings.cityCairoElShorouk;
      case EgyptCity.cairoBadrCity:
        return context.strings.cityCairoBadrCity;
      case EgyptCity.cairoHelwan:
        return context.strings.cityCairoHelwan;
      case EgyptCity.cairoAinShams:
        return context.strings.cityCairoAinShams;
      case EgyptCity.cairoElZaytoun:
        return context.strings.cityCairoElZaytoun;
      case EgyptCity.gizaDokki:
        return context.strings.cityGizaDokki;
      case EgyptCity.gizaMohandessin:
        return context.strings.cityGizaMohandessin;
      case EgyptCity.gizaOctober6th:
        return context.strings.cityGizaOctober6th;
      case EgyptCity.gizaSheikhZayed:
        return context.strings.cityGizaSheikhZayed;
      case EgyptCity.gizaHaram:
        return context.strings.cityGizaHaram;
      case EgyptCity.gizaFaisal:
        return context.strings.cityGizaFaisal;
      case EgyptCity.gizaAgouza:
        return context.strings.cityGizaAgouza;
      case EgyptCity.gizaImbaba:
        return context.strings.cityGizaImbaba;
      case EgyptCity.gizaOmrania:
        return context.strings.cityGizaOmrania;
      case EgyptCity.gizaHawamdia:
        return context.strings.cityGizaHawamdia;
      case EgyptCity.alexandriaSmouha:
        return context.strings.cityAlexandriaSmouha;
      case EgyptCity.alexandriaSidiGaber:
        return context.strings.cityAlexandriaSidiGaber;
      case EgyptCity.alexandriaGleem:
        return context.strings.cityAlexandriaGleem;
      case EgyptCity.alexandriaStanley:
        return context.strings.cityAlexandriaStanley;
      case EgyptCity.alexandriaRoushdy:
        return context.strings.cityAlexandriaRoushdy;
      case EgyptCity.alexandriaMiami:
        return context.strings.cityAlexandriaMiami;
      case EgyptCity.alexandriaMandara:
        return context.strings.cityAlexandriaMandara;
      case EgyptCity.alexandriaMontazah:
        return context.strings.cityAlexandriaMontazah;
      case EgyptCity.alexandriaLoran:
        return context.strings.cityAlexandriaLoran;
      case EgyptCity.alexandriaSanStefano:
        return context.strings.cityAlexandriaSanStefano;
      case EgyptCity.alexandriaAgami:
        return context.strings.cityAlexandriaAgami;
      case EgyptCity.alexandriaBorgElArab:
        return context.strings.cityAlexandriaBorgElArab;
      case EgyptCity.dakahliaMansoura:
        return context.strings.cityDakahliaMansoura;
      case EgyptCity.dakahliaTalkha:
        return context.strings.cityDakahliaTalkha;
      case EgyptCity.dakahliaMitGhamr:
        return context.strings.cityDakahliaMitGhamr;
      case EgyptCity.dakahliaDikirnis:
        return context.strings.cityDakahliaDikirnis;
      case EgyptCity.dakahliaSenbellawein:
        return context.strings.cityDakahliaSenbellawein;
      case EgyptCity.dakahliaBelqas:
        return context.strings.cityDakahliaBelqas;
      case EgyptCity.sharqiaZagazig:
        return context.strings.citySharqiaZagazig;
      case EgyptCity.sharqiaRamadan10th:
        return context.strings.citySharqiaRamadan10th;
      case EgyptCity.sharqiaBelbeis:
        return context.strings.citySharqiaBelbeis;
      case EgyptCity.sharqiaMinyaElQamh:
        return context.strings.citySharqiaMinyaElQamh;
      case EgyptCity.sharqiaFaqous:
        return context.strings.citySharqiaFaqous;
      case EgyptCity.gharbiaTanta:
        return context.strings.cityGharbiaTanta;
      case EgyptCity.gharbiaMahalla:
        return context.strings.cityGharbiaMahalla;
      case EgyptCity.gharbiaZifta:
        return context.strings.cityGharbiaZifta;
      case EgyptCity.gharbiaKafrElZayat:
        return context.strings.cityGharbiaKafrElZayat;
      case EgyptCity.qalyubiaBanha:
        return context.strings.cityQalyubiaBanha;
      case EgyptCity.qalyubiaShubraElKheima:
        return context.strings.cityQalyubiaShubraElKheima;
      case EgyptCity.qalyubiaObour:
        return context.strings.cityQalyubiaObour;
      case EgyptCity.qalyubiaQalyub:
        return context.strings.cityQalyubiaQalyub;
      case EgyptCity.qalyubiaKhanka:
        return context.strings.cityQalyubiaKhanka;
      case EgyptCity.monufiaShibinElKom:
        return context.strings.cityMonufiaShibinElKom;
      case EgyptCity.monufiaMenouf:
        return context.strings.cityMonufiaMenouf;
      case EgyptCity.monufiaAshmoun:
        return context.strings.cityMonufiaAshmoun;
      case EgyptCity.monufiaSadatCity:
        return context.strings.cityMonufiaSadatCity;
      case EgyptCity.monufiaQuesna:
        return context.strings.cityMonufiaQuesna;
      case EgyptCity.beheiraDamanhour:
        return context.strings.cityBeheiraDamanhour;
      case EgyptCity.beheiraKafrElDawwar:
        return context.strings.cityBeheiraKafrElDawwar;
      case EgyptCity.beheiraRosetta:
        return context.strings.cityBeheiraRosetta;
      case EgyptCity.beheiraEdko:
        return context.strings.cityBeheiraEdko;
      case EgyptCity.damiettaDamiettaCity:
        return context.strings.cityDamiettaDamiettaCity;
      case EgyptCity.damiettaNewDamietta:
        return context.strings.cityDamiettaNewDamietta;
      case EgyptCity.damiettaRasElBar:
        return context.strings.cityDamiettaRasElBar;
      case EgyptCity.damiettaFaraskur:
        return context.strings.cityDamiettaFaraskur;
      case EgyptCity.portSaidPortSaidCity:
        return context.strings.cityPortSaidPortSaidCity;
      case EgyptCity.portSaidPortFouad:
        return context.strings.cityPortSaidPortFouad;
      case EgyptCity.portSaidElArab:
        return context.strings.cityPortSaidElArab;
      case EgyptCity.portSaidElZohour:
        return context.strings.cityPortSaidElZohour;
      case EgyptCity.ismailiaIsmailiaCity:
        return context.strings.cityIsmailiaIsmailiaCity;
      case EgyptCity.ismailiaFayed:
        return context.strings.cityIsmailiaFayed;
      case EgyptCity.ismailiaQantara:
        return context.strings.cityIsmailiaQantara;
      case EgyptCity.suezSuezCity:
        return context.strings.citySuezSuezCity;
      case EgyptCity.suezElArbaeen:
        return context.strings.citySuezElArbaeen;
      case EgyptCity.suezAttaka:
        return context.strings.citySuezAttaka;
      case EgyptCity.kafrElSheikhKafrElSheikhCity:
        return context.strings.cityKafrElSheikhKafrElSheikhCity;
      case EgyptCity.kafrElSheikhDesouk:
        return context.strings.cityKafrElSheikhDesouk;
      case EgyptCity.kafrElSheikhBaltim:
        return context.strings.cityKafrElSheikhBaltim;
      case EgyptCity.fayoumFayoumCity:
        return context.strings.cityFayoumFayoumCity;
      case EgyptCity.fayoumSenuris:
        return context.strings.cityFayoumSenuris;
      case EgyptCity.fayoumIbshaway:
        return context.strings.cityFayoumIbshaway;
      case EgyptCity.beniSuefBeniSuefCity:
        return context.strings.cityBeniSuefBeniSuefCity;
      case EgyptCity.beniSuefNewBeniSuef:
        return context.strings.cityBeniSuefNewBeniSuef;
      case EgyptCity.beniSuefElWasti:
        return context.strings.cityBeniSuefElWasti;
      case EgyptCity.minyaMinyaCity:
        return context.strings.cityMinyaMinyaCity;
      case EgyptCity.minyaNewMinya:
        return context.strings.cityMinyaNewMinya;
      case EgyptCity.minyaMallawi:
        return context.strings.cityMinyaMallawi;
      case EgyptCity.minyaSamalut:
        return context.strings.cityMinyaSamalut;
      case EgyptCity.asyutAsyutCity:
        return context.strings.cityAsyutAsyutCity;
      case EgyptCity.asyutNewAsyut:
        return context.strings.cityAsyutNewAsyut;
      case EgyptCity.asyutDairut:
        return context.strings.cityAsyutDairut;
      case EgyptCity.asyutManfalut:
        return context.strings.cityAsyutManfalut;
      case EgyptCity.sohagSohagCity:
        return context.strings.citySohagSohagCity;
      case EgyptCity.sohagNewSohag:
        return context.strings.citySohagNewSohag;
      case EgyptCity.sohagAkhmim:
        return context.strings.citySohagAkhmim;
      case EgyptCity.sohagGirga:
        return context.strings.citySohagGirga;
      case EgyptCity.sohagTahta:
        return context.strings.citySohagTahta;
      case EgyptCity.qenaQenaCity:
        return context.strings.cityQenaQenaCity;
      case EgyptCity.qenaNagHammadi:
        return context.strings.cityQenaNagHammadi;
      case EgyptCity.qenaQus:
        return context.strings.cityQenaQus;
      case EgyptCity.luxorLuxorCity:
        return context.strings.cityLuxorLuxorCity;
      case EgyptCity.luxorEsna:
        return context.strings.cityLuxorEsna;
      case EgyptCity.luxorArmant:
        return context.strings.cityLuxorArmant;
      case EgyptCity.aswanAswanCity:
        return context.strings.cityAswanAswanCity;
      case EgyptCity.aswanNewAswan:
        return context.strings.cityAswanNewAswan;
      case EgyptCity.aswanKomOmbo:
        return context.strings.cityAswanKomOmbo;
      case EgyptCity.aswanEdfu:
        return context.strings.cityAswanEdfu;
      case EgyptCity.redSeaHurghada:
        return context.strings.cityRedSeaHurghada;
      case EgyptCity.redSeaGouna:
        return context.strings.cityRedSeaGouna;
      case EgyptCity.redSeaSafaga:
        return context.strings.cityRedSeaSafaga;
      case EgyptCity.redSeaMarsaAlam:
        return context.strings.cityRedSeaMarsaAlam;
      case EgyptCity.southSinaiSharmElSheikh:
        return context.strings.citySouthSinaiSharmElSheikh;
      case EgyptCity.southSinaiDahab:
        return context.strings.citySouthSinaiDahab;
      case EgyptCity.southSinaiNuweiba:
        return context.strings.citySouthSinaiNuweiba;
      case EgyptCity.southSinaiRasSedr:
        return context.strings.citySouthSinaiRasSedr;
      case EgyptCity.northSinaiArish:
        return context.strings.cityNorthSinaiArish;
      case EgyptCity.northSinaiSheikhZuweid:
        return context.strings.cityNorthSinaiSheikhZuweid;
      case EgyptCity.northSinaiBirElAbd:
        return context.strings.cityNorthSinaiBirElAbd;
      case EgyptCity.matrouhMarsaMatrouh:
        return context.strings.cityMatrouhMarsaMatrouh;
      case EgyptCity.matrouhAlamein:
        return context.strings.cityMatrouhAlamein;
      case EgyptCity.matrouhDabaa:
        return context.strings.cityMatrouhDabaa;
      case EgyptCity.matrouhSiwa:
        return context.strings.cityMatrouhSiwa;
      case EgyptCity.newValleyKharga:
        return context.strings.cityNewValleyKharga;
      case EgyptCity.newValleyDakhla:
        return context.strings.cityNewValleyDakhla;
      case EgyptCity.newValleyFarafra:
        return context.strings.cityNewValleyFarafra;
    }
  }

  static EgyptCity? fromString(
    String? val, {
    EgyptGovernorate? governorate,
    BuildContext? context,
  }) {
    if (val == null || val.trim().isEmpty) return null;
    final normalized = val.trim().toLowerCase();

    final searchList = governorate != null
        ? governorate.cities
        : EgyptCity.values;

    for (final city in searchList) {
      if (city.value.toLowerCase() == normalized ||
          city.name.toLowerCase() == normalized) {
        return city;
      }
      if (context != null &&
          city.localizedName(context).toLowerCase() == normalized) {
        return city;
      }
    }
    return null;
  }

  static String localizedNameFromValue(
    BuildContext context,
    String? val, {
    EgyptGovernorate? governorate,
  }) {
    if (val == null || val.isEmpty) return '';
    final city = EgyptCity.fromString(
      val,
      governorate: governorate,
      context: context,
    );
    return city != null ? city.localizedName(context) : val;
  }
}
