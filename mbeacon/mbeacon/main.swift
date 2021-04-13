
import Foundation
import CoreBluetooth

let currentVersionDescription: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "missing"
let defaults = UserDefaults.standard

let uuid: UUID
if let uuidString = defaults.string(forKey: "uuid") {
    if let result = UUID(uuidString: uuidString) {
        uuid = result
    }
    else {
        fputs("UUID init FAILED", stderr)
        exit(1)
    }
}
else {
    uuid = UUID()
}

let major: UInt16 = UInt16(UserDefaults.standard.integer(forKey: "major"))
let minor: UInt16 = UInt16(UserDefaults.standard.integer(forKey: "minor"))
let measuredPower: Int8 = Int8(UserDefaults.standard.integer(forKey: "measuredPower"))

let advertisement = Advertisement(uuid: uuid, major: major, minor: minor, measuredPower: measuredPower)
let kicker = Kicker(advertisement: advertisement)
let manager = CBPeripheralManager(delegate: kicker, queue: nil)
RunLoop.main.run()
