//
//  LifePointsProtocol.swift
//  SpaceshipShooter2D
//
//  Created by Nikhil Jaggi on 02/10/21.
//

typealias DidRunOutOfHealth = (_ object: AnyObject) -> ()

protocol HealthProtocol {
    var lifePoints: Int { get set }
    var didRunOutOfLifePointsEventHandler: DidRunOutOfHealth? { get set }
}
