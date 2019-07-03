
//
//  Data.swift
//  TripHunters
//
//  Created by oscar Amzalag on 03/07/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import Foundation
import UIKit

var allActivities = [
    Activity(idActivity: 1, idUser: 1, nameActivity: "Wall Street Pigalle", descriptionActivity: "Un Concept Bar Unique à Paris. \n\nÀ partir de 18h le Concept Bar Wall Street Pigalle à Paris se transforme en place boursière pour vous proposer un large portefeuille boursier composé de verres de vins, de pintes de bières et de nombreux cocktails. \n\n5 écrans géants vous permettent de suivre le cours des boissons en direct dont la tendance changera toutes les 100 secondes ! \n\nUn verre peut ainsi passer de 12 à 4 euros en quelques secondes et même subir une décote sans précédent lors d’un des nombreux krachs boursiers qui viendront pimenter chaque soirée.", typeActivity: .NightLife, adresse: "49 Boulevard de Clichy, 75009 Paris", country: "FranceTest", gpsx: 48.88315, gpsy: 2.333989, showActivity: true, imageDesc: [UIImage(named: "activityWallStreet1")!, UIImage(named: "activityWallStreet2")!]),
    
    Activity(idActivity: 2, idUser: 1, nameActivity: "Le musée du Louvre", descriptionActivity: "Avec plus de 460.000 œuvres intemporelles de l’Antiquité à nos jours, le Musée du Louvre est l’un des plus grands musées d’art et d’histoire du monde. \n\nVous y découvrirez des œuvres mondialement connues, telles que La Joconde, La Vénus de Milo, le Radeau de la Méduse, La Liberté guidant le peuple, La mort de la Vierge, La Dentellière, Le Sacre de Napoléon, le Portrait de Louis XIV en costume de sacre, etc.", typeActivity: .Cultural, adresse: "99 rue de Rivoli, 75001 Paris", country: "FranceTest", gpsx: 48.864824, gpsy: 2.334595, showActivity: true, imageDesc: [UIImage(named: "louvre1")!, UIImage(named: "louvre2")!, UIImage(named: "louvre3")!, UIImage(named: "louvre4")!]),
    
    Activity(idActivity: 3, idUser: 2, nameActivity: "Amalfi", descriptionActivity: "ITALIEN – Vous aussi évadez-vous en Italie en dégustant de merveilleuses assiettes dans ce restaurant, des saveurs inédites qui vous font voyager très loin, un véritable plaisir. \n\nLE SOURIRE – Qu’il est agréable de voir une équipe avec le sourire lorsque vous entrez dans un restaurant, pas de doute dans cet établissement on travaille avec le cœur, un plus indéniable !\n\nLE DECOR – Le restaurant Amalfi a mis en place un décor vraiment très intéressant, qu’il s’agisse de la couleur utilisée ou de la disposition des tables, on ne peut que saluer la performance artistique.", typeActivity: .Gastronomy, adresse: "29 Rue de Turin, 75008 Paris", country: "FranceTest", gpsx: 48.88234, gpsy: 2.324264, showActivity: true, imageDesc: [UIImage(named: "Amalfi1")!, UIImage(named: "Amalfi2")!, UIImage(named: "Amalfi3")!]),
    
    Activity(idActivity: 4, idUser: 2, nameActivity: "Playground Duperré", descriptionActivity: "Le terrain de basket Pigalle-Duperré dans le 9e arrondissement fait peau neuve. Une nouvelle fois, c’est Ill studio acompagné de la marque Pigalle et avec le soutient de Nike, qui s’est chargé de refaire les murs et sol du terrain aux allures fantaisistes.\n\nDans une dent creuse de la rue Duperré, entre Saint-Georges et Pigalle, se trouve un terrain de basket pour le moins pittoresque. Déjà à l’œuvre il y a deux ans, Ill Studio avait peint de couleurs primaires en RVB, avec une dominante bleue. Aujourd’hui, on est abasourdi par le sol de dégradés fantastiques et les murs dotés de formes géométriques contrastées. La dissonance avec les murs de briques défraichis des immeubles voisins émerveille.", typeActivity: .Sports, adresse: "22 Rue Duperré, 75009 Paris", country: "FranceTest", gpsx: 48.882097, gpsy:  2.335438, showActivity: true, imageDesc: [UIImage(named: "Duperre1")!, UIImage(named: "Duperre2")!, UIImage(named: "Duperre3")!, UIImage(named: "Duperre4")!]),
    
    Activity(idActivity: 5, idUser: 3, nameActivity: "Le Grand Rex", descriptionActivity: "Le Grand Rex est une salle de cinéma et de spectacle parisienne située au no 1, boulevard Poissonnière dans le 2e arrondissement, sur les grands boulevards.\n\nSes façades et toitures, ainsi que la salle et son décor font l'objet d'une inscription au titre des monuments historiques par arrêté du 5 octobre 19811. Ce cinéma géant peut accueillir plus de 2 700 personnes dans sa grande salle et affiche en moyenne une fréquentation de 1 million de visiteurs par an.", typeActivity: .Entertainement, adresse: "1 Boulevard Poissonnière, 75002 Paris", country: "FranceTest", gpsx: 48.87854, gpsy: 2.28093, showActivity: true, imageDesc: [UIImage(named: "Rex1")!, UIImage(named: "Rex2")!, UIImage(named: "Rex3")!, UIImage(named: "Rex4")!]),
    
    Activity(idActivity: 6, idUser: 3, nameActivity: "Les Catacombes de Paris", descriptionActivity: "Les catacombes de Paris, terme utilisé pour nommer l'ossuaire municipal, sont à l'origine une partie des anciennes carrières souterraines situées dans le 14e arrondissement de Paris, reliées entre elles par des galeries d'inspection. Elles sont transformées en ossuaire municipal à la fin du xviiie siècle avec le transfert des restes d'environ six millions d'individus, évacués des divers cimetières parisiens jusqu'en 1861 pour des raisons de salubrité publique. Elles prennent alors le nom abusif de « catacombes », par analogie avec les nécropoles souterraines de la Rome antique, bien qu'elles n'aient jamais officiellement servi de lieu de sépulture.\n\nD'environ 1,7 km de long visitable, situées à vingt mètres sous la surface, elles sont officiellement visitées par environ 500 000 visiteurs par an (chiffres de 2015) à partir de la place Denfert-Rochereau et constituent un musée de la ville de Paris, dépendant du musée Carnavalet. \n\nCette partie ouverte au public ne représente qu'une infime fraction (environ 0,5 %) des vastes carrières souterraines de Paris, qui s'étendent sous plusieurs arrondissements de la capitale. Il existe aussi d'autres ossuaires souterrains à Paris, inaccessibles au public, et qui demeurent particulièrement méconnus.", typeActivity: .Exploration, adresse: "1 Avenue du Colonel Henri Rol-Tanguy, 75014 Paris", country: "FranceTest", gpsx: 48.862725, gpsy: 2.287592, showActivity: true, imageDesc: [UIImage(named: "Catacombes1")!, UIImage(named: "Catacombes2")!, UIImage(named: "Catacombes3")!]),
    
    Activity(idActivity: 7, idUser: 4, nameActivity: "Le lancer de haches", descriptionActivity: "Les Cognées sont le premier centre de lancer de haches en France.\n\nGrâce aux conseils de nos instructeurs, vous deviendrez rapidement un expert du lancer de haches.\n\nLes 10 cibles des Cognées permettent d’accueillir jusqu’à 30 personnes par session d’une heure.\n\nUne session de lancer des haches aux Cognées est l’activité idéale pour une sortie entre amis, en famille, un anniversaire, un EVG / EVJF ou un team building. ", typeActivity: .Freaky, adresse: "5 Rue Stephenson, 75018 Paris", country: "FranceTest", gpsx: 48.885476, gpsy: 2.356556, showActivity: true, imageDesc: [UIImage(named: "Hache1")!, UIImage(named: "Hache2")!, UIImage(named: "Hache3")!]),
    
    Activity(idActivity: 8, idUser: 5, nameActivity: "La Clairière", descriptionActivity: "Concerts, danse et cocktails dans un cadre verdoyant avec des food-trucks bio disséminés parmi les arbres.", typeActivity: .NightLife, adresse: "1 Rue de Longchamp, 75116 Paris", country: "FranceTest", gpsx: 48.85355, gpsy: 2.23053, showActivity: true, imageDesc: [UIImage(named: "Clairiere1")!, UIImage(named: "Clairiere2")!, UIImage(named: "Clairiere3")!, UIImage(named: "Clairiere4")!]),
    
    Activity(idActivity: 9, idUser: 5, nameActivity: "Le George", descriptionActivity: "L'élégant restaurant Le George, étoilé au Michelin, est à l'image de sa carte inspirée de la cuisine méditerranéenne, qu'il décline dans une version moderne, légère et conçue pour le partage. La fraîcheur des plats de Simone Zanoni ravira vos papilles.", typeActivity: .Gastronomy, adresse: "31 Avenue George V, 75008 Paris", country: "FranceTest", gpsx: 48.868, gpsy: 2.3008, showActivity: true, imageDesc: [UIImage(named: "George1")!, UIImage(named: "George2")!]),
    
    Activity(idActivity: 10, idUser: 3, nameActivity: "Gossima Ping Pong Bar", descriptionActivity: "Debout avec une raquette, une bière ou un cocktail à la main, assis sur un canapé ou autour d'une table de restauration, vous passerez un moment unique dans un lieu qui associe convivialité et bons produits.\n\nLe Gossima vous accueille sans réservation ou organise votre soirée entre amis ou évènement d'entreprise.", typeActivity: .Freaky, adresse: "4 Rue Victor Gelez, 75011 Paris", country: "FranceTest", gpsx: 48.864873, gpsy: 2.382772, showActivity: true, imageDesc: [UIImage(named: "Gossima1")!, UIImage(named: "Gossima2")!, UIImage(named: "Gossima3")!]),
]

var allUsers = [
    User(idUser: 1, pseudo: "TripCodeur", firstName: "Trip", lastName: "Hunters", description: nil, email: "triphunters@hotmail.com", password: "password", nationality: "FranceTest", imageProfil: nil),
    
    User(idUser: 2, pseudo: "OscarAmz", firstName: "Oscar", lastName: "Amzalag", description: nil, email: "triphunters@hotmail.com", password: "password", nationality: "australiaTest", imageProfil: nil),
    
    User(idUser: 3, pseudo: "Annanas", firstName: "Annas", lastName: "Kers", description: nil, email: "triphunters@hotmail.com", password: "password", nationality: "FranceTest", imageProfil: nil),
    
    User(idUser: 4, pseudo: "Janin", firstName: "Janin", lastName: "Ninja", description: nil, email: "triphunters@hotmail.com", password: "password", nationality: "chinaTest", imageProfil: nil),
    
    User(idUser: 5, pseudo: "SimonChe", firstName: "Simon", lastName: "Chevalier", description: nil, email: "triphunters@hotmail.com", password: "password", nationality: "FranceTest", imageProfil: nil),
    
    User(idUser: 6, pseudo: "Bryan", firstName: "Bryan", lastName: "Boo", description: nil, email: "triphunters@hotmail.com", password: "password", nationality: "FranceTest", imageProfil: nil)
]

var allComments = [
    Comment(idActivity: 1, pseudo: "OscarAmz",country: "australiaTest", dateComment: Date(), comment: "Bar très atypique. Le système des prix est à découvrir. Petite terrasse pour se poser en été. Très compliqué de se garer, il fait y aller en transport"),
    Comment(idActivity: 1, pseudo: "Annanas",country: "FranceTest", dateComment: Date(), comment: "Il passe la meilleure musique au monde! L’alcool parfait. Réception et literie imbattable"),
    Comment(idActivity: 1, pseudo: "SimonChe",country: "belgiumTest", dateComment: Date(), comment: "Concept intéressant mais les prix les plus bas sont les prix de bases. Donc un peu cher."),
    Comment(idActivity: 1, pseudo: "Janin",country: "chinaTest", dateComment: Date(), comment: "Le concept est super sympas (prix variant toutes les minutes)"),
    
    Comment(idActivity: 2, pseudo: "Bryan",country: "FranceTest", dateComment: Date(), comment: "C'est vraiment super ! merci beaucoup "),
    Comment(idActivity: 2, pseudo: "Janin",country: "chinaTest", dateComment: Date(), comment: "First"),
    
    Comment(idActivity: 3, pseudo: "OscarAmz",country: "australiaTest", dateComment: Date(), comment: "Génial cette formation"),
    Comment(idActivity: 3, pseudo: "Annanas",country: "FranceTest", dateComment: Date(), comment: "Grave cool"),
    
    Comment(idActivity: 4, pseudo: "Bryan",country: "FranceTest", dateComment: Date(), comment: "Super, top !"),
    Comment(idActivity: 4, pseudo: "Janin",country: "chinaTest", dateComment: Date(), comment: "Je ne m'attendais pas a ça, mais c'etait super ! A faire !!!"),
    Comment(idActivity: 4, pseudo: "OscarAmz",country: "australiaTest", dateComment: Date(), comment: "Salut tout le monde :)"),
    Comment(idActivity: 4, pseudo: "Janin",country: "chinaTest", dateComment: Date(), comment: "Je ne sais vraiment pas quoi ecrire comme commentaire, mais voila"),
    Comment(idActivity: 4, pseudo: "OscarAmz",country: "australiaTest", dateComment: Date(), comment: "Oh ! Mais c'etait top ! Je vais conseiller ma famille d'y aller"),
    Comment(idActivity: 4, pseudo: "Annanas",country: "FranceTest", dateComment: Date(), comment: "Merci"),
    
    Comment(idActivity: 5, pseudo: "OscarAmz",country: "australiaTest", dateComment: Date(), comment: "Trop bien, je vais revenir c'est sur !"),
    Comment(idActivity: 5, pseudo: "Janin",country: "chinaTest", dateComment: Date(), comment: "Mouais, c'etait un peu nul"),
    
    Comment(idActivity: 6, pseudo: "Annanas",country: "FranceTest", dateComment: Date(), comment: "Grave cool"),
    
    Comment(idActivity: 7, pseudo: "Bryan",country: "FranceTest", dateComment: Date(), comment: "Super boy"),
    Comment(idActivity: 7, pseudo: "Janin",country: "chinaTest", dateComment: Date(), comment: ""),
    Comment(idActivity: 7, pseudo: "OscarAmz",country: "australiaTest", dateComment: Date(), comment: "Boy Boy Boyyyyyyyyyyyyyyy"),
    
    Comment(idActivity: 8, pseudo: "TripCodeur",country: "FranceTest", dateComment: Date(), comment: "Trop bien"),
    Comment(idActivity: 8, pseudo: "Janin",country: "chinaTest", dateComment: Date(), comment: "Merci"),
    Comment(idActivity: 8, pseudo: "OscarAmz",country: "australiaTest", dateComment: Date(), comment: "First"),
    Comment(idActivity: 8, pseudo: "TripCodeur",country: "FranceTest", dateComment: Date(), comment: "Coucou tout le monde, je suis le developeur de cette application"),
    Comment(idActivity: 8, pseudo: "Janin",country: "chinaTest", dateComment: Date(), comment: "Bijourrrrr les boooooaaaahhhhh"),
    Comment(idActivity: 8, pseudo: "OscarAmz",country: "australiaTest", dateComment: Date(), comment: "Bon je reviendrai c'est sur !"),
    
    Comment(idActivity: 9, pseudo: "TripCodeur",country: "FranceTest", dateComment: Date(), comment: "Nul"),
    Comment(idActivity: 9, pseudo: "Janin",country: "chinaTest", dateComment: Date(), comment: "Que dire ?"),
    Comment(idActivity: 9, pseudo: "OscarAmz",country: "australiaTest", dateComment: Date(), comment: "Merci"),
    
    Comment(idActivity: 10, pseudo: "Janin",country: "chinaTest", dateComment: Date(), comment: "C'est vraiment super ! merci beaucoup"),
    Comment(idActivity: 10, pseudo: "OscarAmz",country: "australiaTest", dateComment: Date(), comment: "Trop bien"),
    
]

var allFavories = [
    FavoritesActivity(idActivity : 2, idUser: 1, dateFav: Date()),
    FavoritesActivity(idActivity : 3, idUser: 1, dateFav: Date()),
    FavoritesActivity(idActivity : 4, idUser: 1, dateFav: Date()),
    FavoritesActivity(idActivity : 5, idUser: 1, dateFav: Date()),
    
    FavoritesActivity(idActivity : 1, idUser: 2, dateFav: Date()),
    FavoritesActivity(idActivity : 3, idUser: 2, dateFav: Date()),
    
    FavoritesActivity(idActivity : 4, idUser: 3, dateFav: Date()),
    FavoritesActivity(idActivity : 5, idUser: 3, dateFav: Date()),
    FavoritesActivity(idActivity : 8, idUser: 3, dateFav: Date()),
    FavoritesActivity(idActivity : 9, idUser: 3, dateFav: Date()),
    FavoritesActivity(idActivity : 10, idUser: 3, dateFav: Date()),
    
    FavoritesActivity(idActivity : 1, idUser: 4, dateFav: Date()),
    FavoritesActivity(idActivity : 2, idUser: 4, dateFav: Date()),
    FavoritesActivity(idActivity : 3, idUser: 4, dateFav: Date()),
    
    FavoritesActivity(idActivity : 3, idUser: 5, dateFav: Date()),
    FavoritesActivity(idActivity : 4, idUser: 5, dateFav: Date()),
    FavoritesActivity(idActivity : 9, idUser: 5, dateFav: Date()),
    FavoritesActivity(idActivity : 10, idUser: 5, dateFav: Date()),
    
    FavoritesActivity(idActivity : 6, idUser: 6, dateFav: Date()),
    FavoritesActivity(idActivity : 7, idUser: 6, dateFav: Date())
]

var allInscription = [
    
    InscriptionActivity(idActivity : 4, idUser: 1, dateInscription: Date()),
    InscriptionActivity(idActivity : 5, idUser: 1, dateInscription: Date()),
    InscriptionActivity(idActivity : 8, idUser: 1, dateInscription: Date()),
    InscriptionActivity(idActivity : 9, idUser: 1, dateInscription: Date()),
    InscriptionActivity(idActivity : 10, idUser: 1, dateInscription: Date()),
    
    InscriptionActivity(idActivity : 2, idUser: 2, dateInscription: Date()),
    InscriptionActivity(idActivity : 3, idUser: 2, dateInscription: Date()),
    InscriptionActivity(idActivity : 4, idUser: 2, dateInscription: Date()),
    InscriptionActivity(idActivity : 5, idUser: 2, dateInscription: Date()),
    
    InscriptionActivity(idActivity : 1, idUser: 3, dateInscription: Date()),
    InscriptionActivity(idActivity : 3, idUser: 3, dateInscription: Date()),
    
    InscriptionActivity(idActivity : 3, idUser: 4, dateInscription: Date()),
    InscriptionActivity(idActivity : 4, idUser: 4, dateInscription: Date()),
    InscriptionActivity(idActivity : 9, idUser: 4, dateInscription: Date()),
    InscriptionActivity(idActivity : 10, idUser: 4, dateInscription: Date()),
    
    InscriptionActivity(idActivity : 6, idUser: 5, dateInscription: Date()),
    InscriptionActivity(idActivity : 7, idUser: 5, dateInscription: Date()),
    
    InscriptionActivity(idActivity : 1, idUser: 6, dateInscription: Date()),
    InscriptionActivity(idActivity : 2, idUser: 6, dateInscription: Date()),
    InscriptionActivity(idActivity : 3, idUser: 6, dateInscription: Date()),
]
