//
//  Created by Bodrov Aleksandr on 03.07.2023.
//  Copyright © 2023 Sberbank. All rights reserved.
//

import XcodeProj
import Foundation

enum Cached<T> {
	case cached(T)
	case nothing

	var value: T? {
		switch self {
		case let .cached(value): return value
		case .nothing: return nil
		}
	}
}

final class CacheContainer {
	let value: Cached<BuildSettings>

	init(value: Cached<BuildSettings>) {
		self.value = value
	}
}

extension NSCache where KeyType == NSString, ObjectType == CacheContainer {
	subscript(aKey: String) -> Cached<BuildSettings>? {
		get {
			object(forKey: aKey as NSString)?.value
		}
		set {
			if let value = newValue {
				setObject(CacheContainer(value: value), forKey: aKey as NSString)
			} else {
				removeObject(forKey: aKey as NSString)
			}
		}
	}
}
