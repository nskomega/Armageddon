//
//  ArmageddonResponse.swift
//  Armageddon
//
//  Created by Mikhail Danilov on 19.04.2022.
//

import Foundation

// MARK: - ArmageddonResponse
class ArmageddonResponse: Codable {
    let links: ArmageddonResponseLinks
    let elementCount: Int
    let nearEarthObjects: [String: [NearEarthObject]]

    enum CodingKeys: String, CodingKey {
        case links
        case elementCount = "element_count"
        case nearEarthObjects = "near_earth_objects"
    }

    init(links: ArmageddonResponseLinks, elementCount: Int, nearEarthObjects: [String: [NearEarthObject]]) {
        self.links = links
        self.elementCount = elementCount
        self.nearEarthObjects = nearEarthObjects
    }
}

// MARK: - ArmageddonResponseLinks
class ArmageddonResponseLinks: Codable {
    let next, prev, linksSelf: String

    enum CodingKeys: String, CodingKey {
        case next, prev
        case linksSelf = "self"
    }

    init(next: String, prev: String, linksSelf: String) {
        self.next = next
        self.prev = prev
        self.linksSelf = linksSelf
    }
}

// MARK: - NearEarthObject
class NearEarthObject: Codable {
    let links: NearEarthObjectLinks
    let id, neoReferenceID, name: String
    let nasaJplURL: String
    let absoluteMagnitudeH: Double
    let estimatedDiameter: EstimatedDiameter
    let isPotentiallyHazardousAsteroid: Bool
    let closeApproachData: [CloseApproachDatum]
    let isSentryObject: Bool

    enum CodingKeys: String, CodingKey {
        case links, id
        case neoReferenceID = "neo_reference_id"
        case name
        case nasaJplURL = "nasa_jpl_url"
        case absoluteMagnitudeH = "absolute_magnitude_h"
        case estimatedDiameter = "estimated_diameter"
        case isPotentiallyHazardousAsteroid = "is_potentially_hazardous_asteroid"
        case closeApproachData = "close_approach_data"
        case isSentryObject = "is_sentry_object"
    }

    init(links: NearEarthObjectLinks, id: String, neoReferenceID: String, name: String, nasaJplURL: String, absoluteMagnitudeH: Double, estimatedDiameter: EstimatedDiameter, isPotentiallyHazardousAsteroid: Bool, closeApproachData: [CloseApproachDatum], isSentryObject: Bool) {
        self.links = links
        self.id = id
        self.neoReferenceID = neoReferenceID
        self.name = name
        self.nasaJplURL = nasaJplURL
        self.absoluteMagnitudeH = absoluteMagnitudeH
        self.estimatedDiameter = estimatedDiameter
        self.isPotentiallyHazardousAsteroid = isPotentiallyHazardousAsteroid
        self.closeApproachData = closeApproachData
        self.isSentryObject = isSentryObject
    }
}

// MARK: - CloseApproachDatum
class CloseApproachDatum: Codable {
    let closeApproachDate, closeApproachDateFull: String
    let epochDateCloseApproach: Int
    let relativeVelocity: RelativeVelocity
    let missDistance: MissDistance
    let orbitingBody: OrbitingBody

    enum CodingKeys: String, CodingKey {
        case closeApproachDate = "close_approach_date"
        case closeApproachDateFull = "close_approach_date_full"
        case epochDateCloseApproach = "epoch_date_close_approach"
        case relativeVelocity = "relative_velocity"
        case missDistance = "miss_distance"
        case orbitingBody = "orbiting_body"
    }

    init(closeApproachDate: String, closeApproachDateFull: String, epochDateCloseApproach: Int, relativeVelocity: RelativeVelocity, missDistance: MissDistance, orbitingBody: OrbitingBody) {
        self.closeApproachDate = closeApproachDate
        self.closeApproachDateFull = closeApproachDateFull
        self.epochDateCloseApproach = epochDateCloseApproach
        self.relativeVelocity = relativeVelocity
        self.missDistance = missDistance
        self.orbitingBody = orbitingBody
    }
}

// MARK: - MissDistance
class MissDistance: Codable {
    let astronomical, lunar, kilometers, miles: String

    init(astronomical: String, lunar: String, kilometers: String, miles: String) {
        self.astronomical = astronomical
        self.lunar = lunar
        self.kilometers = kilometers
        self.miles = miles
    }
}

enum OrbitingBody: String, Codable {
    case earth = "Earth"
}

// MARK: - RelativeVelocity
class RelativeVelocity: Codable {
    let kilometersPerSecond, kilometersPerHour, milesPerHour: String

    enum CodingKeys: String, CodingKey {
        case kilometersPerSecond = "kilometers_per_second"
        case kilometersPerHour = "kilometers_per_hour"
        case milesPerHour = "miles_per_hour"
    }

    init(kilometersPerSecond: String, kilometersPerHour: String, milesPerHour: String) {
        self.kilometersPerSecond = kilometersPerSecond
        self.kilometersPerHour = kilometersPerHour
        self.milesPerHour = milesPerHour
    }
}

// MARK: - EstimatedDiameter
class EstimatedDiameter: Codable {
    let kilometers, meters, miles, feet: Feet

    init(kilometers: Feet, meters: Feet, miles: Feet, feet: Feet) {
        self.kilometers = kilometers
        self.meters = meters
        self.miles = miles
        self.feet = feet
    }
}

// MARK: - Feet
class Feet: Codable {
    let estimatedDiameterMin, estimatedDiameterMax: Double

    enum CodingKeys: String, CodingKey {
        case estimatedDiameterMin = "estimated_diameter_min"
        case estimatedDiameterMax = "estimated_diameter_max"
    }

    init(estimatedDiameterMin: Double, estimatedDiameterMax: Double) {
        self.estimatedDiameterMin = estimatedDiameterMin
        self.estimatedDiameterMax = estimatedDiameterMax
    }
}

// MARK: - NearEarthObjectLinks
class NearEarthObjectLinks: Codable {
    let linksSelf: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }

    init(linksSelf: String) {
        self.linksSelf = linksSelf
    }
}
