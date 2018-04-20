
import Foundation
import CoreBluetooth

struct Advertisement: CustomStringConvertible {
    var uuid: UUID
    var major: UInt16
    var minor: UInt16
    var measuredPower: Int8
    
    var dictionaryRepresentation: [String: Any] {
        var buffer = [CUnsignedChar](repeating: 0, count: 21)
        (uuid as NSUUID).getBytes(&buffer)
        buffer[16] = CUnsignedChar(major >> 8)
        buffer[17] = CUnsignedChar(major & 0xFF)
        buffer[18] = CUnsignedChar(minor >> 8)
        buffer[19] = CUnsignedChar(minor & 0xFF)
        buffer[20] = CUnsignedChar(bitPattern: measuredPower)
        let data = Data(bytes: buffer, count: buffer.count)
        return ["kCBAdvDataAppleBeaconKey": data]
    }
    
    var description: String {
        return "uuid: \(uuid), major: \(major), minor: \(minor), measuredPower: \(measuredPower)\n"
    }
}

class Kicker: NSObject, CBPeripheralManagerDelegate {
    let advertisement: Advertisement
    
    init(advertisement: Advertisement) {
        self.advertisement = advertisement
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            peripheral.startAdvertising(advertisement.dictionaryRepresentation)
        }
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if let error = error {
            fputs("error \(error.localizedDescription)", stderr)
            exit(1)
        }
        else {
            fputs(advertisement.description, stdout)
        }
    }
}
