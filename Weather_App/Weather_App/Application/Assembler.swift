//
//  Assembler.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import Foundation

protocol Assembler: AnyObject,
                    AppAssembler,
                    TabbarAssembler,
                    MapAssembler,
                    DetailAssembler,
                    FavoriteAssembler,
                    GatewaysAssembler {
}

final class DefaultAssembler: Assembler {
}
