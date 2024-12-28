//
//  ATSesionManager.swift
//  Blu
//
//  Created by Aranza Manriquez Alonso on 26/12/24.
//

import Foundation
import Alamofire

class ATSesionManager {
    static let instance = ATSesionManager()

        // Configuración de la sesión con Alamofire
    private let session: Session = {
            // Configuración de URLSession
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 180 // Tiempo de espera para solicitudes

            // Crear el ServerTrustManager con políticas personalizadas
            let serverTrustManager = ServerTrustManager(evaluators: [
                "dog.ceo": DisabledTrustEvaluator(), // Deshabilitar la evaluación de confianza para "dog.ceo"
                "reqres.in": DisabledTrustEvaluator() // Deshabilitar la evaluación de confianza para "reqres.in"
            ])

            // Crear y devolver la instancia de Alamofire.Session
            return Session(configuration: configuration, serverTrustManager: serverTrustManager)
        }()

        // Método para acceder a la sesión
        func getSession() -> Session {
            return session
        }
    }
