//
//  SettingsModel.swift
//
//
//  Created by Douglas Adams on 10/2/23.
//

import CoreAudio
import SwiftUI

import SharedModel

@Observable
public class SettingsModel {
  // ----------------------------------------------------------------------------
  // MARK: - Singleton

  public static var shared = SettingsModel()
  
  // ----------------------------------------------------------------------------
  // MARK: - Public properties

  public var selectedSetting: String
  public var selectedEqualizerId: String
  public var sidePanelOptions: SidePanelOptions
  public var daxPanelOptions: DaxPanelOptions

  public var cwxEnabled: Bool

  // ---------- Default Connection ----------
  public var guiDefault: DefaultConnection?
  public var nonGuiDefault: DefaultConnection?
  
  // ---------- Color Settings ----------
  public var background: Color
  public var dbLegend: Color
  public var dbLines: Color
  public var flagBackground: Color = .black
  public var frequencyLegend: Color
  public var gridLines: Color
  public var marker: Color
  public var markerEdge: Color
  public var markerSegment: Color
  public var sliceActive: Color
  public var sliceFilter: Color
  public var sliceInactive: Color
  public var spectrumLine: Color
  public var spectrumFill: Color
  public var tnfDeep: Color
  public var tnfInactive: Color
  public var tnfNormal: Color
  public var tnfPermanent: Color
  public var tnfVeryDeep: Color
  public var waterfallClear: Color = .black
  
  // ---------- Connection Settings ----------
  public var directEnabled: Bool
  public var isGui: Bool
  public var localEnabled: Bool
  public var loginRequired: Bool
  public var mtuValue: Int
  public var refreshToken: String?
  public var requireSmartlinkLogin: Bool
  public var smartlinkEnabled: Bool
  public var smartlinkUser: String
  public var stationName: String
  public var useDefault: Bool
  public var knownRadios: [KnownRadio]
  
  // ---------- Misc Settings ----------
  public var alertOnError: Bool
  public var ignoreTimeStamps: Bool
  public var logBroadcasts: Bool
  public var monitorShortName: String
  
  // ---------- Profile Settings ----------
  public var selectedProfileType: String
  
  // ---------- Radio Settings ----------
  public var openControls: Bool
  public var singleClickTuneEnabled: Bool
  public var sliceMinimizedEnabled: Bool
  
  // --------- Panadapter Settings ----------
  public var dbSpacing: Int
  public var markersEnabled: Bool
  public var spectrumFillLevel: Double
  public var spectrumType: String
  
  // --------- Log Viewer Settings ----------
  public var logViewerAutoRefresh: Bool
  public var logViewerFontSize: CGFloat
  public var logViewerGoToLast: Bool
  public var logViewerShowLevel: LogLevel
  public var logViewerShowTimestamps: Bool
  public var logViewerFilterBy: LogFilter
  public var logViewerFilterText: String

  // --------- Mac Audio Settings ----------
  public var remoteRxAudioCompressed: Bool
  public var remoteRxAudioEnabled: Bool
  public var remoteRxAudioMute: Bool
  public var remoteRxAudioOutputDeviceId: Int
  public var remoteRxAudioVolume: Float
  
  public var remoteTxAudioEnabled: Bool
  public var remoteTxAudioInputDeviceId: Int

  // --------- DAX Settings ----------
  public var daxReducedBandwidth: Bool
  public var daxMicSetting: DaxSetting
  public var daxRxSetting: DaxSetting
  public var daxTxSetting: DaxSetting

  public var guiClientId: UUID?
  
  public var altAntennaNames: [AntennaName]

  public var sliceBackground: Color = .black

  public var spectrumGradientColor0: Color = .white.opacity(0.4)
  public var spectrumGradientColor1: Color = .green
  public var spectrumGradientColor2: Color = .yellow
  public var spectrumGradientColor3: Color = .red
  public var spectrumGradientStop0: Double = 0.2
  public var spectrumGradientStop1: Double = 0.4
  public var spectrumGradientStop2: Double = 0.5
  public var spectrumGradientStop3: Double = 0.6
  
  // ----------------------------------------------------------------------------
  // MARK: - Static properties

  public static let FlexSuite = "group.net.k3tzr.flexapps"

  // ----------------------------------------------------------------------------
  // MARK: - Private properties

  private let FlexDefaults = UserDefaults(suiteName: SettingsModel.FlexSuite)!
  
  // ----------------------------------------------------------------------------
  // MARK: - Public methods

  private init() {
        
    // first usage?
    if FlexDefaults.bool(forKey: "initialized") == false {
      // YES, populate and save to UserDefaults
      selectedSetting = SelectedSetting.radio.rawValue
      
      guiDefault = nil
      nonGuiDefault = nil
      
      refreshToken = nil
      
      sidePanelOptions = []
      daxPanelOptions = []

      selectedEqualizerId = "rxsc"
      
      cwxEnabled = false
      
      // ---------- Color Settings ----------
      background = .black
      dbLegend = .green
      dbLines = .white.opacity(0.3)
      frequencyLegend = .green
      gridLines = .white.opacity(0.3)
      marker = .yellow
      markerEdge = .red.opacity(0.2)
      markerSegment = .white.opacity(0.2)
      sliceActive = .red
      sliceFilter = .white.opacity(0.2)
      sliceInactive = .yellow
      spectrumLine = .white
      spectrumFill = .white
      tnfDeep = .yellow.opacity(0.2)
      tnfInactive = .white.opacity(0.2)
      tnfNormal = .green.opacity(0.2)
      tnfPermanent = .white
      tnfVeryDeep = .red.opacity(0.2)
      
      // ---------- Connection Settings ----------
      directEnabled = false
      isGui = true
      localEnabled = true
      loginRequired = false
      mtuValue = 1_300
      refreshToken = ""
      requireSmartlinkLogin = false
      smartlinkEnabled = false
      smartlinkUser = ""
      stationName = "Sdr6000"
      useDefault = false
      knownRadios = [KnownRadio]()
      
      // ---------- Misc Settings ----------
      alertOnError = false
      ignoreTimeStamps = true
      logBroadcasts = false
      monitorShortName = "13.8"
      
      // ---------- Profile Settings ----------
      selectedProfileType = "mic"
      
      // ---------- Radio Settings ----------
      singleClickTuneEnabled = false
      sliceMinimizedEnabled = false
      openControls = false
      
      // --------- Panadapter Settings ----------
      spectrumType = SpectrumType.line.rawValue
      spectrumFillLevel = 0
      dbSpacing = 10
      markersEnabled = false
      
      // --------- Log Viewer Settings ----------
      logViewerAutoRefresh = false
      logViewerFontSize = 12
      logViewerGoToLast = true
      logViewerShowLevel = .debug
      logViewerShowTimestamps = false
      logViewerFilterBy = .none
      logViewerFilterText = ""
      
      // --------- Mac Audio Settings ----------
      remoteRxAudioCompressed = true
      remoteRxAudioEnabled = false
      remoteRxAudioMute = false
      remoteRxAudioOutputDeviceId = 0
      remoteRxAudioVolume = 0.5

      remoteTxAudioEnabled = false
      remoteTxAudioInputDeviceId = 0

      // --------- DAX Settings ----------
      daxReducedBandwidth = true
      daxMicSetting = DaxSetting(channel: 1)
      daxRxSetting = DaxSetting(channel: 1)
      daxTxSetting = DaxSetting(channel: 1)

      guiClientId = UUID()
      
      altAntennaNames = [AntennaName]()
      
      save()

    } else {
      // NO, initialize from UserDefaults
      
      selectedSetting = FlexDefaults.string(forKey: "selectedSetting") ?? SelectedSetting.radio.rawValue
      
      guiDefault = SettingsModel.getStructFromSettings("guiDefault", defaults: FlexDefaults)
      nonGuiDefault = SettingsModel.getStructFromSettings("nonGuiDefault", defaults: FlexDefaults)
      
      refreshToken = FlexDefaults.string(forKey: ConnectionSetting.smartlinkUser.rawValue)
      
      sidePanelOptions = SidePanelOptions(rawValue: UInt8(FlexDefaults.integer(forKey: "sidePanelOptions")))
      daxPanelOptions = DaxPanelOptions(rawValue: UInt8(FlexDefaults.integer(forKey: "daxPanelOptions")))

      selectedEqualizerId = FlexDefaults.string(forKey: "selectedEqualizerId") ?? "rxsc"
      
      cwxEnabled = FlexDefaults.bool(forKey: "cwxEnabled")

      // ---------- Color Settings ----------
      background = Color(rawValue: FlexDefaults.string(forKey: AppColor.background.rawValue)!)!
      dbLegend = Color(rawValue: FlexDefaults.string(forKey: AppColor.dbLegend.rawValue)!)!
      dbLines = Color(rawValue: FlexDefaults.string(forKey: AppColor.dbLines.rawValue)!)!
      frequencyLegend = Color(rawValue: FlexDefaults.string(forKey: AppColor.frequencyLegend.rawValue)!)!
      gridLines = Color(rawValue: FlexDefaults.string(forKey: AppColor.gridLines.rawValue)!)!
      marker = Color(rawValue: FlexDefaults.string(forKey: AppColor.marker.rawValue)!)!
      markerEdge = Color(rawValue: FlexDefaults.string(forKey: AppColor.markerEdge.rawValue)!)!
      markerSegment = Color(rawValue: FlexDefaults.string(forKey: AppColor.markerSegment.rawValue)!)!
      sliceActive = Color(rawValue: FlexDefaults.string(forKey: AppColor.sliceActive.rawValue)!)!
      sliceFilter = Color(rawValue: FlexDefaults.string(forKey: AppColor.sliceFilter.rawValue)!)!
      sliceInactive = Color(rawValue: FlexDefaults.string(forKey: AppColor.sliceInactive.rawValue)!)!
      spectrumLine = Color(rawValue: FlexDefaults.string(forKey: AppColor.spectrumLine.rawValue)!)!
      spectrumFill = Color(rawValue: FlexDefaults.string(forKey: AppColor.spectrumFill.rawValue)!)!
      tnfDeep = Color(rawValue: FlexDefaults.string(forKey: AppColor.tnfDeep.rawValue)!)!
      tnfInactive = Color(rawValue: FlexDefaults.string(forKey: AppColor.tnfInactive.rawValue)!)!
      tnfNormal = Color(rawValue: FlexDefaults.string(forKey: AppColor.tnfNormal.rawValue)!)!
      tnfPermanent = Color(rawValue: FlexDefaults.string(forKey: AppColor.tnfPermanent.rawValue)!)!
      tnfVeryDeep = Color(rawValue: FlexDefaults.string(forKey: AppColor.tnfVeryDeep.rawValue)!)!
      
      // ---------- Connection Settings ----------
      directEnabled = FlexDefaults.bool(forKey: ConnectionSetting.directEnabled.rawValue)
      isGui = FlexDefaults.bool(forKey: ConnectionSetting.isGui.rawValue)
      localEnabled = FlexDefaults.bool(forKey: ConnectionSetting.localEnabled.rawValue)
      loginRequired = FlexDefaults.bool(forKey: ConnectionSetting.loginRequired.rawValue)
      mtuValue = FlexDefaults.integer(forKey: ConnectionSetting.mtuValue.rawValue)
      refreshToken = FlexDefaults.string(forKey: ConnectionSetting.refreshToken.rawValue) ?? ""
      requireSmartlinkLogin = FlexDefaults.bool(forKey: ConnectionSetting.requireSmartlinkLogin.rawValue)
      smartlinkEnabled = FlexDefaults.bool(forKey: ConnectionSetting.smartlinkEnabled.rawValue)
      smartlinkUser = FlexDefaults.string(forKey: ConnectionSetting.smartlinkUser.rawValue) ?? ""
      stationName = FlexDefaults.string(forKey: ConnectionSetting.stationName.rawValue) ?? "Sdr6000"
      useDefault = FlexDefaults.bool(forKey: ConnectionSetting.useDefault.rawValue)
      knownRadios = FlexDefaults.object(forKey: ConnectionSetting.knownRadios.rawValue) as? [KnownRadio] ?? [KnownRadio]()
      
      // ---------- Misc Settings ----------
      alertOnError = FlexDefaults.bool(forKey: MiscSetting.alertOnError.rawValue)
      ignoreTimeStamps = FlexDefaults.bool(forKey: MiscSetting.ignoreTimeStamps.rawValue)
      logBroadcasts = FlexDefaults.bool(forKey: MiscSetting.logBroadcasts.rawValue)
      monitorShortName = FlexDefaults.string(forKey: MiscSetting.monitorShortName.rawValue) ?? ""
      
      // ---------- Profile Settings ----------
      selectedProfileType = FlexDefaults.string(forKey: ProfileSetting.selectedProfileType.rawValue) ?? ""
      
      // ---------- Radio Settings ----------
      singleClickTuneEnabled = FlexDefaults.bool(forKey: RadioSetting.singleClickTuneEnabled.rawValue)
      sliceMinimizedEnabled = FlexDefaults.bool(forKey: RadioSetting.sliceMinimizedEnabled.rawValue)
      openControls = FlexDefaults.bool(forKey: RadioSetting.openControls.rawValue)
      
      // --------- Panadapter Settings ----------
      spectrumType = FlexDefaults.string(forKey: PanadapterSetting.spectrumType.rawValue) ?? ""
      spectrumFillLevel = FlexDefaults.double(forKey: PanadapterSetting.spectrumFillLevel.rawValue)
      dbSpacing = FlexDefaults.integer(forKey: PanadapterSetting.dbSpacing.rawValue)
      markersEnabled = FlexDefaults.bool(forKey: PanadapterSetting.markersEnabled.rawValue)
      
      // --------- Log Viewer Settings ----------
      logViewerAutoRefresh = FlexDefaults.bool(forKey: "logViewerAutoRefresh")
      logViewerFontSize = FlexDefaults.double(forKey: "logViewerFontSize")
      logViewerGoToLast = FlexDefaults.bool(forKey: "logViewerGoToLast")
      logViewerShowLevel = LogLevel(rawValue: FlexDefaults.string(forKey: "logViewerShowLevel") ?? LogLevel.info.rawValue)!
      logViewerShowTimestamps = FlexDefaults.bool(forKey: "logViewerShowTimeStamps")
      logViewerFilterBy = LogFilter(rawValue: FlexDefaults.string(forKey: "logViewerFilterBy") ?? LogFilter.none.rawValue)!
      logViewerFilterText = FlexDefaults.string(forKey: "logViewerFilterText") ?? ""
      
      // --------- Mac Audio Settings ----------
      remoteRxAudioCompressed = FlexDefaults.bool(forKey: "remoteRxAudioCompressed")
      remoteRxAudioEnabled = FlexDefaults.bool(forKey: "remoteRxAudioEnabled")
      remoteRxAudioMute = FlexDefaults.bool(forKey: "remoteRxAudioMute")
      remoteRxAudioOutputDeviceId = FlexDefaults.integer(forKey: "remoteRxAudioOutputDeviceId")
      remoteRxAudioVolume = FlexDefaults.float(forKey: "remoteRxAudioVolume")
      
      remoteTxAudioEnabled = FlexDefaults.bool(forKey: "remoteTxAudioEnabled")
      remoteTxAudioInputDeviceId = FlexDefaults.integer(forKey: "remoteTxAudioInputDeviceId")

      // --------- DAX Settings ----------
      daxReducedBandwidth = FlexDefaults.bool(forKey: "daxReducedBandwidth")
      daxMicSetting = SettingsModel.getStructFromSettings("daxMicSetting", defaults: FlexDefaults) ?? DaxSetting(channel: 1) as DaxSetting
      daxRxSetting = SettingsModel.getStructFromSettings("daxRxSetting", defaults: FlexDefaults) ?? DaxSetting(channel: 1) as DaxSetting
      daxTxSetting = SettingsModel.getStructFromSettings("daxTxSetting", defaults: FlexDefaults) ?? DaxSetting(channel: 1) as DaxSetting


      guiClientId = UUID(uuidString: FlexDefaults.string(forKey: "guiClientId") ?? "")
      
      altAntennaNames = FlexDefaults.object(forKey: "altAntennaNames") as? [AntennaName] ?? [AntennaName]()
    }
  }
}

// ---------- SettingsModel Extension ----------
extension SettingsModel {
  // Public methods
  
  // save to UserDefaults
  public func save() {
    
    // mark it as initialized
    FlexDefaults.set(true, forKey: "initialized")
    
    // save all values
    FlexDefaults.set(selectedSetting, forKey: "selectedSetting")
    
    SettingsModel.saveStructToSettings("guiDefault", guiDefault, defaults: FlexDefaults)
    SettingsModel.saveStructToSettings("nonGuiDefault", nonGuiDefault, defaults: FlexDefaults)
    
    FlexDefaults.set(refreshToken, forKey: "refreshToken")
    
    FlexDefaults.set(sidePanelOptions.rawValue, forKey: "sidePanelOptions")
    FlexDefaults.set(daxPanelOptions.rawValue, forKey: "daxPanelOptions")

    FlexDefaults.set(selectedEqualizerId, forKey: "selectedEqualizerId")
    
    FlexDefaults.set(cwxEnabled, forKey: "cwxEnabled")
    
    // ---------- Colors ----------
    FlexDefaults.set(background.rawValue, forKey: AppColor.background.rawValue)
    FlexDefaults.set(dbLegend.rawValue, forKey: AppColor.dbLegend.rawValue)
    FlexDefaults.set(dbLines.rawValue, forKey: AppColor.dbLines.rawValue)
    FlexDefaults.set(frequencyLegend.rawValue, forKey: AppColor.frequencyLegend.rawValue)
    FlexDefaults.set(gridLines.rawValue, forKey: AppColor.gridLines.rawValue)
    FlexDefaults.set(marker.rawValue, forKey: AppColor.marker.rawValue)
    FlexDefaults.set(markerEdge.rawValue, forKey: AppColor.markerEdge.rawValue)
    FlexDefaults.set(markerSegment.rawValue, forKey: AppColor.markerSegment.rawValue)
    FlexDefaults.set(sliceActive.rawValue, forKey: AppColor.sliceActive.rawValue)
    FlexDefaults.set(sliceFilter.rawValue, forKey: AppColor.sliceFilter.rawValue)
    FlexDefaults.set(sliceInactive.rawValue, forKey: AppColor.sliceInactive.rawValue)
    FlexDefaults.set(spectrumLine.rawValue, forKey: AppColor.spectrumLine.rawValue)
    FlexDefaults.set(spectrumFill.rawValue, forKey: AppColor.spectrumFill.rawValue)
    FlexDefaults.set(tnfDeep.rawValue, forKey: AppColor.tnfDeep.rawValue)
    FlexDefaults.set(tnfInactive.rawValue, forKey: AppColor.tnfInactive.rawValue)
    FlexDefaults.set(tnfNormal.rawValue, forKey: AppColor.tnfNormal.rawValue)
    FlexDefaults.set(tnfPermanent.rawValue, forKey: AppColor.tnfPermanent.rawValue)
    FlexDefaults.set(tnfVeryDeep.rawValue, forKey: AppColor.tnfVeryDeep.rawValue)
    
    // ---------- Connection Settings ----------
    FlexDefaults.set(directEnabled, forKey: ConnectionSetting.directEnabled.rawValue)
    FlexDefaults.set(isGui, forKey: ConnectionSetting.isGui.rawValue)
    FlexDefaults.set(localEnabled, forKey: ConnectionSetting.localEnabled.rawValue)
    FlexDefaults.set(loginRequired, forKey: ConnectionSetting.loginRequired.rawValue)
    FlexDefaults.set(mtuValue, forKey: ConnectionSetting.mtuValue.rawValue)
    FlexDefaults.set(refreshToken, forKey: ConnectionSetting.refreshToken.rawValue)
    FlexDefaults.set(requireSmartlinkLogin, forKey: ConnectionSetting.requireSmartlinkLogin.rawValue)
    FlexDefaults.set(smartlinkEnabled, forKey: ConnectionSetting.smartlinkEnabled.rawValue)
    FlexDefaults.set(smartlinkUser, forKey: ConnectionSetting.smartlinkUser.rawValue)
    FlexDefaults.set(stationName, forKey: ConnectionSetting.stationName.rawValue)
    FlexDefaults.set(useDefault, forKey: ConnectionSetting.useDefault.rawValue)
    FlexDefaults.set(knownRadios, forKey: ConnectionSetting.knownRadios.rawValue)
    
    // ---------- Misc Settings ----------
    FlexDefaults.set(alertOnError, forKey: MiscSetting.alertOnError.rawValue)
    FlexDefaults.set(ignoreTimeStamps, forKey: MiscSetting.ignoreTimeStamps.rawValue)
    FlexDefaults.set(logBroadcasts, forKey: MiscSetting.logBroadcasts.rawValue)
    FlexDefaults.set(monitorShortName, forKey: MiscSetting.monitorShortName.rawValue)
    
    // ---------- Profile Settings ----------
    FlexDefaults.set(selectedProfileType, forKey: ProfileSetting.selectedProfileType.rawValue)
    
    // ---------- Radio Settings ----------
    FlexDefaults.set(singleClickTuneEnabled, forKey: RadioSetting.singleClickTuneEnabled.rawValue)
    FlexDefaults.set(sliceMinimizedEnabled, forKey: RadioSetting.sliceMinimizedEnabled.rawValue)
    FlexDefaults.set(openControls, forKey: RadioSetting.openControls.rawValue)
    
    // ---------- Panadapter Settings ----------
    FlexDefaults.set(spectrumType, forKey: PanadapterSetting.spectrumType.rawValue)
    FlexDefaults.set(spectrumFillLevel, forKey: PanadapterSetting.spectrumFillLevel.rawValue)
    FlexDefaults.set(dbSpacing, forKey: PanadapterSetting.dbSpacing.rawValue)
    FlexDefaults.set(markersEnabled, forKey: PanadapterSetting.markersEnabled.rawValue)
    
    // --------- Log Viewer Settings ----------
    FlexDefaults.set(logViewerAutoRefresh, forKey: "logViewerAutoRefresh")
    FlexDefaults.set(logViewerFontSize, forKey: "logViewerFontSize")
    FlexDefaults.set(logViewerGoToLast, forKey: "logViewerGoToLast")
    FlexDefaults.set(logViewerShowLevel.rawValue, forKey: "logViewerShowLevel")
    FlexDefaults.set(logViewerShowTimestamps, forKey: "logViewerShowTimestamps")
    FlexDefaults.set(logViewerFilterBy.rawValue, forKey: "logViewerFilterBy")
    FlexDefaults.set(logViewerFilterText, forKey: "logViewerFilterText")
    
    // --------- Mac Audio Settings ----------
    FlexDefaults.set(remoteRxAudioCompressed, forKey: "remoteRxAudioCompressed")
    FlexDefaults.set(remoteRxAudioEnabled, forKey: "remoteRxAudioEnabled")
    FlexDefaults.set(remoteRxAudioMute, forKey: "remoteRxAudioMute")
    FlexDefaults.set(remoteRxAudioOutputDeviceId, forKey: "remoteRxAudioOutputDeviceId")
    FlexDefaults.set(remoteRxAudioVolume, forKey: "remoteRxAudioVolume")

    FlexDefaults.set(remoteTxAudioEnabled, forKey: "remoteTxAudioEnabled")
    FlexDefaults.set(remoteTxAudioInputDeviceId, forKey: "remoteTxAudioInputDeviceId")

    // --------- DAX Settings ----------
    FlexDefaults.set(daxReducedBandwidth, forKey: "daxReducedBandwidth")
    SettingsModel.saveStructToSettings("daxMicSetting", daxMicSetting, defaults: FlexDefaults)
    SettingsModel.saveStructToSettings("daxRxSetting", daxRxSetting, defaults: FlexDefaults)
    SettingsModel.saveStructToSettings("daxTxSetting", daxTxSetting, defaults: FlexDefaults)

    
    FlexDefaults.set(guiClientId?.uuidString, forKey: "guiClientId")
    
    FlexDefaults.set(altAntennaNames, forKey: "altAntennaNames")
    
    
  }
  
  public func setGuiClientId(_ id: String) {
    guiClientId = UUID(uuidString: id)
  }
  
  // reset a color to it's initial value
  public func reset(_ color: AppColor){
    // ---------- Colors ----------
    switch color {
    case .background: background = .black
    case .dbLegend: dbLegend = .green
    case .dbLines: dbLines = .white.opacity(0.3)
    case .frequencyLegend: frequencyLegend = .green
    case .gridLines: gridLines = .white.opacity(0.3)
    case .marker: marker = .yellow
    case .markerEdge: markerEdge = .red.opacity(0.2)
    case .markerSegment: markerSegment = .white.opacity(0.2)
    case .sliceActive: sliceActive = .red
    case .sliceFilter: sliceFilter = .white.opacity(0.2)
    case .sliceInactive: sliceInactive = .yellow
    case .spectrumLine: spectrumLine = .white
    case .spectrumFill: spectrumFill = .white
    case .tnfDeep: tnfDeep = .yellow.opacity(0.2)
    case .tnfInactive: tnfInactive = .white.opacity(0.2)
    case .tnfNormal: tnfNormal = .green.opacity(0.2)
    case .tnfPermanent: tnfPermanent = .white
    case .tnfVeryDeep: tnfVeryDeep = .red.opacity(0.2)
    }
  }
  
  // reset ALL colors to their initial values
  public func reset() {
    // ---------- Colors ----------
    for color in AppColor.allCases {
      reset(color)
    }
    save()
  }
  
  // ----------------------------------------------------------------------------
  // MARK: - Public class methods
  
  /// Read a user default entry and decode it into a struct
  /// - Parameters:
  ///    - key:         the name of the user default
  /// - Returns:        a struct (or nil)
  public class func getStructFromSettings<T: Decodable>(_ key: String, defaults: UserDefaults) -> T? {
    
    if let data = defaults.object(forKey: key) as? Data {
      let decoder = JSONDecoder()
      if let value = try? decoder.decode(T.self, from: data) {
        return value
      } else {
        return nil
      }
    }
    return nil
  }
  
  /// Encode a struct and write it to a user default
  /// - Parameters:
  ///    - key:        the name of the user default
  ///    - value:      a struct  to be encoded (or nil)
  public class func saveStructToSettings<T: Encodable>(_ key: String, _ value: T?, defaults: UserDefaults) {
    
    if value == nil {
      defaults.removeObject(forKey: key)
    } else {
      let encoder = JSONEncoder()
      if let encoded = try? encoder.encode(value) {
        defaults.set(encoded, forKey: key)
      } else {
        defaults.removeObject(forKey: key)
      }
    }
  }
  
  public class func getArrayOfStruct<T: Decodable>(_ key: String, defaults: UserDefaults) -> [T]?{
    if let data = defaults.data(forKey: key) {
        
      let array = try! PropertyListDecoder().decode([T].self, from: data)
      return array
    }
    return nil
  }

  public class func saveArrayOfStruct<T: Encodable>(_ key: String, _ array: [T], defaults: UserDefaults) {
    if let data = try? PropertyListEncoder().encode(array) {
      defaults.set(data, forKey: key)
    }
  }
  
  // ----------------------------------------------------------------------------
  // MARK: - Public enums and structs
  
  // Enums
  public enum SelectedSetting: String {
    case radio = "Radio"
    case network = "Network"
    case gps = "GPS"
    case tx = "Transmit"
    case phoneCw = "Phone CW"
    case xvtrs = "Xvtrs"
    case profiles = "Profiles"
    case colors = "Colors"
    case misc = "Misc"
    case connection = "Connection"
  }
  
  public enum AppColor: String, CaseIterable {
    case background
    case dbLegend
    case dbLines
    case frequencyLegend
    case gridLines
    case marker
    case markerEdge
    case markerSegment
    case sliceActive
    case sliceFilter
    case sliceInactive
    case spectrumLine
    case spectrumFill
    case tnfDeep
    case tnfInactive
    case tnfNormal
    case tnfPermanent
    case tnfVeryDeep
  }
  
  public enum ConnectionSetting: String {
    case directEnabled
    case isGui
    case localEnabled
    case knownRadios
    case loginRequired
    case mtuValue
    case refreshToken
    case requireSmartlinkLogin
    case smartlinkEnabled
    case smartlinkUser
    case stationName
    case useDefault
  }
  
  public enum MiscSetting: String {
    case monitorShortName
    case logBroadcasts
    case ignoreTimeStamps
    case alertOnError
  }
  
  public enum ProfileSetting: String {
    case selectedProfileType
  }
  
  public enum ProfileType: String {
    case mic
    case tx
    case global
  }
  
  public enum RadioSetting: String {
    case singleClickTuneEnabled
    case sliceMinimizedEnabled
    case openControls
  }
  
  public enum PanadapterSetting: String {
    case spectrumType
    case spectrumFillLevel
    case dbSpacing
    case markersEnabled
    case rxAudioEnabled
    case txAudioEnabled
  }
  
  public enum SpectrumType: String, Equatable, CaseIterable {
    case line = "Line"
    case filled = "Filled"
    case gradient = "Gradient"
  }
  
  // Structs
  public struct KnownRadio: Identifiable, Hashable, Codable {
    public var id: UUID
    public var name: String
    public var ipAddress: String
    
    public init(_ name: String, _ location: String, _ ipAddress: String) {
      self.id = UUID()
      self.name = name
      self.ipAddress = ipAddress
    }
  }
  
  public struct AntennaName: Hashable, Codable {
    public init(stdName: String, customName: String) {
      self.stdName = stdName
      self.customName = customName
    }
    
    public var stdName: String
    public var customName: String
  }
  
  public struct DefaultConnection: Equatable, Codable {
    public var serial: String
    public var source: String
    public var station: String?
    
    public init
    (
      _ serial: String, _ source: String, _ station: String?
    )
    {
      self.serial = serial
      self.source = source
      self.station = station
    }
  }
  
  public struct SidePanelOptions: OptionSet {
    
    public init(rawValue: UInt8) {
      self.rawValue = rawValue
    }
    
    public let rawValue: UInt8
    
    public static let rx  = SidePanelOptions(rawValue: 1 << 0)
    public static let tx  = SidePanelOptions(rawValue: 1 << 1)
    public static let ph1 = SidePanelOptions(rawValue: 1 << 2)
    public static let ph2 = SidePanelOptions(rawValue: 1 << 3)
    public static let cw  = SidePanelOptions(rawValue: 1 << 4)
    public static let eq  = SidePanelOptions(rawValue: 1 << 5)
    
    public static let all: SidePanelOptions = [.rx, .tx, .ph1, ph2, .cw, .eq]
  }
  
  public struct DaxPanelOptions: OptionSet {
    
    public init(rawValue: UInt8) {
      self.rawValue = rawValue
    }
    
    public let rawValue: UInt8
    
    public static let tx  = DaxPanelOptions(rawValue: 1 << 0)
    public static let mic = DaxPanelOptions(rawValue: 1 << 1)
    public static let rx = DaxPanelOptions(rawValue: 1 << 2)
    public static let iq = DaxPanelOptions(rawValue: 1 << 3)
    
    public static let all: DaxPanelOptions = [.tx, .mic, .rx, iq]
  }
}

// ---------- Color Extension ----------
extension Color: RawRepresentable {
  public init?(rawValue: String) {
    guard let data = Data(base64Encoded: rawValue) else {
      // invalid raw value
      return nil
    }
    
    do {
      let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSColor.self, from: data) ?? .systemPink
     self = Color(color)
    } catch {
      self = .pink
    }
  }
  
  public var rawValue: String {
    do {
      let data = try NSKeyedArchiver.archivedData(withRootObject: NSColor(self), requiringSecureCoding: false) as Data
      return data.base64EncodedString()
    } catch {
      return ""
    }
  }
}
