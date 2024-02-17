//
//  Recipe.swift
//
//
//  Created by Themis Makedas on 5/2/24.
//

import Foundation
import SwiftUI

public struct Recipe: Identifiable, Equatable, Codable {
    
    public var id: String
    public var iconAsseTitle: String
    public var title: String
    public var description: String
    public var ingredients: String
    public var method: String
    public var serves: Int
    public var timeInSeconds: Int
    public var difficulty: RecipeDifficulty?
    public var chefId: String
    public var chefUsername: Username
    public var chefName: Name
    public var isFavourite: Bool
    
    public var totalTime: String {
        
        var time = ""
        let maxTime = 24 * 60 * 60
        let clampedTime = min(max(timeInSeconds, 0), maxTime)
        
        let hours = clampedTime / 3600
        let minutes = (clampedTime % 3600) / 60

        if hours > 0 {
            let hoursText = hours == 1 ? "Hour" : "Hours"
            time = hours == 1 ? "\(String(hours)) \(hoursText)" : "\(String(hours)) \(hoursText)"
        }
        
        if minutes > 0 {
            let minutesText = minutes == 1 ? "Minute" : "Minutes"
            time += " \(String(minutes)) \(minutesText)"
        }
        
        return time
    }
    
    public static var recipe_1: Recipe {
        Recipe(
            id: "1",
            iconAsseTitle: "Recipe_1",
            title: "Recipe_1",
            description: "Description_1",
            ingredients: """
            \u{2022} 1 x 700 g jar of chickpeas
            \u{2022} ½ a clove of garlic
            \u{2022} ground cumin
            \u{2022} extra virgin olive oil
            \u{2022} 2 tablespoons tahini
            \u{2022} 2 tablespoons tahini
            \u{2022} 1 lemon
            """,
            method: """
            1. Tip 1 x 700g jar of chickpeas (juices and all) into a blender.
            2. Peel and add ½ a clove of garlic, along with a good pinch of sea salt, black pepper and ground cumin.
            3. Drizzle in 4 tablespoons of extra virgin olive oil and 2 tablespoons of tahini.
            4. Finely grate in the zest of ½ a lemon zest and squeeze in all the juice, then whiz until super-smooth and silky.
            5. Taste and adjust the seasoning, if needed, then decant back into the original jar for storing in the fridge. To serve, I like to make a well in the middle, kiss it with a little bit of extra virgin olive oil and a pinch of ground cumin.
            """,
            serves: 2,
            timeInSeconds: 3700,
            difficulty: .init(rawValue: 4),
            chefId: "1",
            chefUsername: Username(rawValue: "Username_1")!,
            chefName: Name(rawValue: "Name_1")!,
            isFavourite: true
        )
    }
    
    public static var recipe_2: Recipe {
        Recipe(
            id: "2",
            iconAsseTitle: "Recipe_2",
            title: "Recipe_2",
            description: "Description_2",
            ingredients: """
            \u{2022} 1 x 700 g jar of chickpeas
            \u{2022} ½ a clove of garlic
            \u{2022} ground cumin
            \u{2022} extra virgin olive oil
            \u{2022} 2 tablespoons tahini
            \u{2022} 2 tablespoons tahini
            \u{2022} 1 lemon
            """,
            method: """
            1. Tip 1 x 700g jar of chickpeas (juices and all) into a blender.
            2. Peel and add ½ a clove of garlic, along with a good pinch of sea salt, black pepper and ground cumin.
            3. Drizzle in 4 tablespoons of extra virgin olive oil and 2 tablespoons of tahini.
            4. Finely grate in the zest of ½ a lemon zest and squeeze in all the juice, then whiz until super-smooth and silky.
            5. Taste and adjust the seasoning, if needed, then decant back into the original jar for storing in the fridge. To serve, I like to make a well in the middle, kiss it with a little bit of extra virgin olive oil and a pinch of ground cumin.
            """,
            serves: 3,
            timeInSeconds: 3000,
            difficulty: .init(rawValue: 1),
            chefId: "2",
            chefUsername: Username(rawValue: "Username_2")!,
            chefName: Name(rawValue: "Name_2")!,
            isFavourite: true
        )
    }
    
    public static var recipe_3: Recipe {
        Recipe(
            id: "3",
            iconAsseTitle: "Recipe_3",
            title: "Recipe_3",
            description: "Description_3",
            ingredients: """
        \u{2022} 1 x 700 g jar of chickpeas
        \u{2022} ½ a clove of garlic
        \u{2022} ground cumin
        \u{2022} extra virgin olive oil
        \u{2022} 2 tablespoons tahini
        \u{2022} 2 tablespoons tahini
        \u{2022} 1 lemon
        """,
            method: """
        1. Tip 1 x 700g jar of chickpeas (juices and all) into a blender.
        2. Peel and add ½ a clove of garlic, along with a good pinch of sea salt, black pepper and ground cumin.
        3. Drizzle in 4 tablespoons of extra virgin olive oil and 2 tablespoons of tahini.
        4. Finely grate in the zest of ½ a lemon zest and squeeze in all the juice, then whiz until super-smooth and silky.
        5. Taste and adjust the seasoning, if needed, then decant back into the original jar for storing in the fridge. To serve, I like to make a well in the middle, kiss it with a little bit of extra virgin olive oil and a pinch of ground cumin.
        """,
            serves: 4,
            timeInSeconds: 4500,
            difficulty: .init(rawValue: 2),
            chefId: "3",
            chefUsername: Username(rawValue: "Username_3")!,
            chefName: Name(rawValue: "Name_3")!,
            isFavourite: true
        )
    }
    
    public static var recipe_4: Recipe {
        Recipe(
            id: "4",
            iconAsseTitle: "Recipe_4",
            title: "Recipe_4",
            description: "Description_4",
            ingredients: """
            \u{2022} 1 x 700 g jar of chickpeas
            \u{2022} ½ a clove of garlic
            \u{2022} ground cumin
            \u{2022} extra virgin olive oil
            \u{2022} 2 tablespoons tahini
            \u{2022} 2 tablespoons tahini
            \u{2022} 1 lemon
            """,
            method: """
            1. Tip 1 x 700g jar of chickpeas (juices and all) into a blender.
            2. Peel and add ½ a clove of garlic, along with a good pinch of sea salt, black pepper and ground cumin.
            3. Drizzle in 4 tablespoons of extra virgin olive oil and 2 tablespoons of tahini.
            4. Finely grate in the zest of ½ a lemon zest and squeeze in all the juice, then whiz until super-smooth and silky.
            5. Taste and adjust the seasoning, if needed, then decant back into the original jar for storing in the fridge. To serve, I like to make a well in the middle, kiss it with a little bit of extra virgin olive oil and a pinch of ground cumin.
            """,
            serves: 5,
            timeInSeconds: 6000,
            difficulty: .init(rawValue: 3),
            chefId: "4",
            chefUsername: Username(rawValue: "Username_4")!,
            chefName: Name(rawValue: "Name_4")!,
            isFavourite: true
        )
    }
    
    public static var recipe_5: Recipe {
        Recipe(
            id: "5",
            iconAsseTitle: "Recipe_5",
            title: "Recipe_5",
            description: "Description_5",
            ingredients: """
            \u{2022} 1 x 700 g jar of chickpeas
            \u{2022} ½ a clove of garlic
            \u{2022} ground cumin
            \u{2022} extra virgin olive oil
            \u{2022} 2 tablespoons tahini
            \u{2022} 2 tablespoons tahini
            \u{2022} 1 lemon
            """,
            method: """
            1. Tip 1 x 700g jar of chickpeas (juices and all) into a blender.
            2. Peel and add ½ a clove of garlic, along with a good pinch of sea salt, black pepper and ground cumin.
            3. Drizzle in 4 tablespoons of extra virgin olive oil and 2 tablespoons of tahini.
            4. Finely grate in the zest of ½ a lemon zest and squeeze in all the juice, then whiz until super-smooth and silky.
            5. Taste and adjust the seasoning, if needed, then decant back into the original jar for storing in the fridge. To serve, I like to make a well in the middle, kiss it with a little bit of extra virgin olive oil and a pinch of ground cumin.
            """,
            serves: 2,
            timeInSeconds: 8000,
            difficulty: .init(rawValue: 4),
            chefId: "5",
            chefUsername: Username(rawValue: "Username_5")!,
            chefName: Name(rawValue: "Name_5")!,
            isFavourite: true
        )
    }
    
    public static var recipe_6: Recipe {
        Recipe(
            id: "6",
            iconAsseTitle: "Recipe_6",
            title: "Recipe_6",
            description: "Description_6",
            ingredients: """
            \u{2022} 1 x 700 g jar of chickpeas
            \u{2022} ½ a clove of garlic
            \u{2022} ground cumin
            \u{2022} extra virgin olive oil
            \u{2022} 2 tablespoons tahini
            \u{2022} 2 tablespoons tahini
            \u{2022} 1 lemon
            """,
            method: """
            1. Tip 1 x 700g jar of chickpeas (juices and all) into a blender.
            2. Peel and add ½ a clove of garlic, along with a good pinch of sea salt, black pepper and ground cumin.
            3. Drizzle in 4 tablespoons of extra virgin olive oil and 2 tablespoons of tahini.
            4. Finely grate in the zest of ½ a lemon zest and squeeze in all the juice, then whiz until super-smooth and silky.
            5. Taste and adjust the seasoning, if needed, then decant back into the original jar for storing in the fridge. To serve, I like to make a well in the middle, kiss it with a little bit of extra virgin olive oil and a pinch of ground cumin.
            """,
            serves: 3,
            timeInSeconds: 4500,
            difficulty: .init(rawValue: 2),
            chefId: "6",
            chefUsername: Username(rawValue: "Username_6")!,
            chefName: Name(rawValue: "Name_6")!,
            isFavourite: false
        )
    }
    
    public static var recipe_7: Recipe {
        Recipe(
            id: "7",
            iconAsseTitle: "Recipe_7",
            title: "Recipe_7",
            description: "Description_7",
            ingredients: """
            \u{2022} 1 x 700 g jar of chickpeas
            \u{2022} ½ a clove of garlic
            \u{2022} ground cumin
            \u{2022} extra virgin olive oil
            \u{2022} 2 tablespoons tahini
            \u{2022} 2 tablespoons tahini
            \u{2022} 1 lemon
            """,
            method: """
            1. Tip 1 x 700g jar of chickpeas (juices and all) into a blender.
            2. Peel and add ½ a clove of garlic, along with a good pinch of sea salt, black pepper and ground cumin.
            3. Drizzle in 4 tablespoons of extra virgin olive oil and 2 tablespoons of tahini.
            4. Finely grate in the zest of ½ a lemon zest and squeeze in all the juice, then whiz until super-smooth and silky.
            5. Taste and adjust the seasoning, if needed, then decant back into the original jar for storing in the fridge. To serve, I like to make a well in the middle, kiss it with a little bit of extra virgin olive oil and a pinch of ground cumin.
            """,
            serves: 4,
            timeInSeconds: 3600,
            difficulty: .init(rawValue: 1),
            chefId: "7",
            chefUsername: Username(rawValue: "Username_7")!,
            chefName: Name(rawValue: "Name_7")!,
            isFavourite: false
        )
    }
    
    public static var recipe_8: Recipe {
        Recipe(
            id: "8",
            iconAsseTitle: "Recipe_8",
            title: "Recipe_8",
            description: "Description_8",
            ingredients: """
            \u{2022} 1 x 700 g jar of chickpeas
            \u{2022} ½ a clove of garlic
            \u{2022} ground cumin
            \u{2022} extra virgin olive oil
            \u{2022} 2 tablespoons tahini
            \u{2022} 2 tablespoons tahini
            \u{2022} 1 lemon
            """,
            method: """
            1. Tip 1 x 700g jar of chickpeas (juices and all) into a blender.
            2. Peel and add ½ a clove of garlic, along with a good pinch of sea salt, black pepper and ground cumin.
            3. Drizzle in 4 tablespoons of extra virgin olive oil and 2 tablespoons of tahini.
            4. Finely grate in the zest of ½ a lemon zest and squeeze in all the juice, then whiz until super-smooth and silky.
            5. Taste and adjust the seasoning, if needed, then decant back into the original jar for storing in the fridge. To serve, I like to make a well in the middle, kiss it with a little bit of extra virgin olive oil and a pinch of ground cumin.
            """,
            serves: 5,
            timeInSeconds: 10000,
            difficulty: .init(rawValue: 5),
            chefId: "8",
            chefUsername: Username(rawValue: "Username_8")!,
            chefName: Name(rawValue: "Name_8")!,
            isFavourite: false
        )
    }
    
    public static var recipe_9: Recipe {
        Recipe(
            id: "9",
            iconAsseTitle: "Recipe_9",
            title: "Recipe_9",
            description: "Description_9",
            ingredients: """
            \u{2022} 1 x 700 g jar of chickpeas
            \u{2022} ½ a clove of garlic
            \u{2022} ground cumin
            \u{2022} extra virgin olive oil
            \u{2022} 2 tablespoons tahini
            \u{2022} 2 tablespoons tahini
            \u{2022} 1 lemon
            """,
            method: """
            1. Tip 1 x 700g jar of chickpeas (juices and all) into a blender.
            2. Peel and add ½ a clove of garlic, along with a good pinch of sea salt, black pepper and ground cumin.
            3. Drizzle in 4 tablespoons of extra virgin olive oil and 2 tablespoons of tahini.
            4. Finely grate in the zest of ½ a lemon zest and squeeze in all the juice, then whiz until super-smooth and silky.
            5. Taste and adjust the seasoning, if needed, then decant back into the original jar for storing in the fridge. To serve, I like to make a well in the middle, kiss it with a little bit of extra virgin olive oil and a pinch of ground cumin.
            """,
            serves: 2,
            timeInSeconds: 9500,
            difficulty: .init(rawValue: 2),
            chefId: "9",
            chefUsername: Username(rawValue: "Username_9")!,
            chefName: Name(rawValue: "Name_9")!,
            isFavourite: false
        )
    }
    
    public static var recipe_10: Recipe {
        Recipe(
            id: "10",
            iconAsseTitle: "Recipe_10",
            title: "Recipe_10",
            description: "Description_10",
            ingredients: """
            \u{2022} 1 x 700 g jar of chickpeas
            \u{2022} ½ a clove of garlic
            \u{2022} ground cumin
            \u{2022} extra virgin olive oil
            \u{2022} 2 tablespoons tahini
            \u{2022} 2 tablespoons tahini
            \u{2022} 1 lemon
            """,
            method: """
            1. Tip 1 x 700g jar of chickpeas (juices and all) into a blender.
            2. Peel and add ½ a clove of garlic, along with a good pinch of sea salt, black pepper and ground cumin.
            3. Drizzle in 4 tablespoons of extra virgin olive oil and 2 tablespoons of tahini.
            4. Finely grate in the zest of ½ a lemon zest and squeeze in all the juice, then whiz until super-smooth and silky.
            5. Taste and adjust the seasoning, if needed, then decant back into the original jar for storing in the fridge. To serve, I like to make a well in the middle, kiss it with a little bit of extra virgin olive oil and a pinch of ground cumin.
            """,
            serves: 4,
            timeInSeconds: 11000,
            difficulty: .init(rawValue: 5),
            chefId: "10",
            chefUsername: Username(rawValue: "Username_10")!,
            chefName: Name(rawValue: "Name_10")!,
            isFavourite: false
        )
    }
    
    public static var previewHomeExamples: [Recipe] {
        [recipe_1, recipe_2, recipe_3, recipe_4, recipe_5, recipe_6, recipe_7, recipe_8, recipe_9, recipe_10]
    }
    
    public static var previewFavouritesExamples: [Recipe] {
        previewHomeExamples.filter({ $0.isFavourite })
    }
}
