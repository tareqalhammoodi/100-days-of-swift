//
//  Country.swift
//  Milestone-Projects 13-15
//
//  Created by Tareq Alhammoodi on 13.08.2023.
//

import Foundation

struct Country: Codable {
    let name: Name
    let tld: [String]?
    let cca2: String
    let ccn3: String?
    let cca3: String
    let cioc: String?
    let independent: Bool?
    let status: Status
    let unMember: Bool
    let currencies: Currencies?
    let idd: Idd
    let capital: [String]?
    let altSpellings: [String]
    let region: Region
    let subregion: String?
    let languages: [String: String]?
    let translations: [String: Translation]
    let latlng: [Double]
    let landlocked: Bool
    let borders: [String]?
    let area: Double
    let demonyms: Demonyms?
    let flag: String
    let maps: Maps
    let population: Int
    let fifa: String?
    let car: Car
    let timezones: [String]
    let continents: [Continent]
    let flags: Flags
    let coatOfArms: CoatOfArms
    let startOfWeek: StartOfWeek
    let capitalInfo: CapitalInfo
    let postalCode: PostalCode?
    let gini: [String: Double]?
}

// MARK: - CapitalInfo
struct CapitalInfo: Codable {
    let latlng: [Double]?
}

// MARK: - Car
struct Car: Codable {
    let signs: [String]?
    let side: Side
}

enum Side: String, Codable {
    case sideLeft = "left"
    case sideRight = "right"
}

// MARK: - CoatOfArms
struct CoatOfArms: Codable {
    let png: String?
    let svg: String?
}

enum Continent: String, Codable {
    case africa = "Africa"
    case antarctica = "Antarctica"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case oceania = "Oceania"
    case southAmerica = "South America"
}

// MARK: - Currencies
struct Currencies: Codable {
    let chf, bzd, mkd, gbp: Aed?
    let jep, mop, pyg, awg: Aed?
    let lkr, eur, ang, xof: Aed?
    let egp, mru, nzd, amd: Aed?
    let ern, lsl, zar, pkr: Aed?
    let ggp, gip, isk, bhd: Aed?
    let uzs, mur, gtq, zwl: Aed?
    let xcd, uah, xpf, bdt: Aed?
    let mwk, aud, kid, nok: Aed?
    let bob, xaf, szl, aoa: Aed?
    let ils, jod, mxn, nio: Aed?
    let jmd, syp, usd, shp: Aed?
    let tnd, dkk, jpy, gyd: Aed?
    let iqd, mad, pgk, ugx: Aed?
    let azn, czk, pen, tjs: Aed?
    let ron, top, ssp, mvr: Aed?
    let currenciesTRY, rwf, irr, uyu: Aed?
    let tmt, kpw, thb, inr: Aed?
    let fok, lyd, mzn, etb: Aed?
    let lbp, kyd, mdl, lak: Aed?
    let ngn, clp, bbd, zmw: Aed?
    let bif, sll, sos, sar: Aed?
    let aed, khr, nad, tzs: Aed?
    let fjd, sgd, gmd, dop: Aed?
    let ves, byn, npr, pln: Aed?
    let myr, cve, ghs: Aed?
    let bam: BAM?
    let bsd, kgs, vuv, tvd: Aed?
    let hnl, sbd, wst, bmd: Aed?
    let dzd, bnd, afn, djf: Aed?
    let sdg: BAM?
    let vnd, krw, btn, cdf: Aed?
    let huf, omr, rub, cny: Aed?
    let kwd, sek, bwp, kmf: Aed?
    let htg, bgn, rsd, cuc: Aed?
    let cup, brl, cop, stn: Aed?
    let php, all, srd, lrd: Aed?
    let ars, idr, scr, qar: Aed?
    let cad, hkd, kes, ckd: Aed?
    let mnt, ttd, yer, pab: Aed?
    let twd, mmk, fkp, kzt: Aed?
    let gel, crc, mga, gnf: Aed?
    let imp: Aed?

    enum CodingKeys: String, CodingKey {
        case chf = "CHF"
        case bzd = "BZD"
        case mkd = "MKD"
        case gbp = "GBP"
        case jep = "JEP"
        case mop = "MOP"
        case pyg = "PYG"
        case awg = "AWG"
        case lkr = "LKR"
        case eur = "EUR"
        case ang = "ANG"
        case xof = "XOF"
        case egp = "EGP"
        case mru = "MRU"
        case nzd = "NZD"
        case amd = "AMD"
        case ern = "ERN"
        case lsl = "LSL"
        case zar = "ZAR"
        case pkr = "PKR"
        case ggp = "GGP"
        case gip = "GIP"
        case isk = "ISK"
        case bhd = "BHD"
        case uzs = "UZS"
        case mur = "MUR"
        case gtq = "GTQ"
        case zwl = "ZWL"
        case xcd = "XCD"
        case uah = "UAH"
        case xpf = "XPF"
        case bdt = "BDT"
        case mwk = "MWK"
        case aud = "AUD"
        case kid = "KID"
        case nok = "NOK"
        case bob = "BOB"
        case xaf = "XAF"
        case szl = "SZL"
        case aoa = "AOA"
        case ils = "ILS"
        case jod = "JOD"
        case mxn = "MXN"
        case nio = "NIO"
        case jmd = "JMD"
        case syp = "SYP"
        case usd = "USD"
        case shp = "SHP"
        case tnd = "TND"
        case dkk = "DKK"
        case jpy = "JPY"
        case gyd = "GYD"
        case iqd = "IQD"
        case mad = "MAD"
        case pgk = "PGK"
        case ugx = "UGX"
        case azn = "AZN"
        case czk = "CZK"
        case pen = "PEN"
        case tjs = "TJS"
        case ron = "RON"
        case top = "TOP"
        case ssp = "SSP"
        case mvr = "MVR"
        case currenciesTRY = "TRY"
        case rwf = "RWF"
        case irr = "IRR"
        case uyu = "UYU"
        case tmt = "TMT"
        case kpw = "KPW"
        case thb = "THB"
        case inr = "INR"
        case fok = "FOK"
        case lyd = "LYD"
        case mzn = "MZN"
        case etb = "ETB"
        case lbp = "LBP"
        case kyd = "KYD"
        case mdl = "MDL"
        case lak = "LAK"
        case ngn = "NGN"
        case clp = "CLP"
        case bbd = "BBD"
        case zmw = "ZMW"
        case bif = "BIF"
        case sll = "SLL"
        case sos = "SOS"
        case sar = "SAR"
        case aed = "AED"
        case khr = "KHR"
        case nad = "NAD"
        case tzs = "TZS"
        case fjd = "FJD"
        case sgd = "SGD"
        case gmd = "GMD"
        case dop = "DOP"
        case ves = "VES"
        case byn = "BYN"
        case npr = "NPR"
        case pln = "PLN"
        case myr = "MYR"
        case cve = "CVE"
        case ghs = "GHS"
        case bam = "BAM"
        case bsd = "BSD"
        case kgs = "KGS"
        case vuv = "VUV"
        case tvd = "TVD"
        case hnl = "HNL"
        case sbd = "SBD"
        case wst = "WST"
        case bmd = "BMD"
        case dzd = "DZD"
        case bnd = "BND"
        case afn = "AFN"
        case djf = "DJF"
        case sdg = "SDG"
        case vnd = "VND"
        case krw = "KRW"
        case btn = "BTN"
        case cdf = "CDF"
        case huf = "HUF"
        case omr = "OMR"
        case rub = "RUB"
        case cny = "CNY"
        case kwd = "KWD"
        case sek = "SEK"
        case bwp = "BWP"
        case kmf = "KMF"
        case htg = "HTG"
        case bgn = "BGN"
        case rsd = "RSD"
        case cuc = "CUC"
        case cup = "CUP"
        case brl = "BRL"
        case cop = "COP"
        case stn = "STN"
        case php = "PHP"
        case all = "ALL"
        case srd = "SRD"
        case lrd = "LRD"
        case ars = "ARS"
        case idr = "IDR"
        case scr = "SCR"
        case qar = "QAR"
        case cad = "CAD"
        case hkd = "HKD"
        case kes = "KES"
        case ckd = "CKD"
        case mnt = "MNT"
        case ttd = "TTD"
        case yer = "YER"
        case pab = "PAB"
        case twd = "TWD"
        case mmk = "MMK"
        case fkp = "FKP"
        case kzt = "KZT"
        case gel = "GEL"
        case crc = "CRC"
        case mga = "MGA"
        case gnf = "GNF"
        case imp = "IMP"
    }
}

// MARK: - Aed
struct Aed: Codable {
    let name, symbol: String
}

// MARK: - BAM
struct BAM: Codable {
    let name: String
}

// MARK: - Demonyms
struct Demonyms: Codable {
    let eng: Eng
    let fra: Eng?
}

// MARK: - Eng
struct Eng: Codable {
    let f, m: String
}

// MARK: - Flags
struct Flags: Codable {
    let png: String
    let svg: String
    let alt: String?
}

// MARK: - Idd
struct Idd: Codable {
    let root: String?
    let suffixes: [String]?
}

// MARK: - Maps
struct Maps: Codable {
    let googleMaps, openStreetMaps: String
}

// MARK: - Name
struct Name: Codable {
    let common, official: String
    let nativeName: [String: Translation]?
}

// MARK: - Translation
struct Translation: Codable {
    let official, common: String
}

// MARK: - PostalCode
struct PostalCode: Codable {
    let format: String
    let regex: String?
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case antarctic = "Antarctic"
    case asia = "Asia"
    case europe = "Europe"
    case oceania = "Oceania"
}

enum StartOfWeek: String, Codable {
    case monday = "monday"
    case saturday = "saturday"
    case sunday = "sunday"
}

enum Status: String, Codable {
    case officiallyAssigned = "officially-assigned"
    case userAssigned = "user-assigned"
}


