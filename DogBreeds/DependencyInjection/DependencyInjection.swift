enum SessionWrapperComposer: Composer {
    static func compose() -> SessionWrapper {
        SessionWrapperImpl()
    }
}

enum NetworkCoreComposer: Composer {
    static func compose() -> NetworkCore {
        NetworkCoreImpl(session: SessionWrapperComposer.compose())
    }
}

enum NetworkClientComposer: Composer {
    static func compose() -> NetworkClient {
        DogBreedNetworkClient(networkCore: NetworkCoreComposer.compose())
    }
}

enum RouterComposer: MainComposer {
    static func compose() -> Router {
        RouterImpl(
            screenProvider: ScreenProviderComposer.compose(),
            screenMapper: ScreenMapperComposer.compose()        )
    }
}

enum ScreenProviderComposer: MainComposer {
    private static let shared = ScreenProvider(
        mapper: ScreenMapperComposer.compose(),
        rootFactory: RootFactoryComposer.compose()
    )
    static func compose() -> ScreenProvider {
        shared
    }
}

enum RootFactoryComposer: MainComposer {
    static func compose() -> RootFactory {
        RootFactoryImpl(listViewModelFactory: ListViewModelFactoryComposer.compose())
    }
}

enum ListNavigationDelegateComposer: MainComposer {
    static func compose() -> ListNavigationDelegate {
        ListNavigationDelegateImpl(
            router: RouterComposer.compose()
        )
    }
}

enum ScreenMapperComposer: MainComposer {
    static func compose() -> ScreenMapper {
        ScreenMapperImpl(
            listViewModelFactory: ListViewModelFactoryComposer.compose(),
            detailsViewModelFactory: DetailsViewModelFactoryComposer.compose()
        )
    }
}

enum ListViewModelFactoryComposer: MainComposer {
    static func compose() -> ListViewModelFactory {
        ListViewModelFactoryImpl(navigation: ListNavigationDelegateComposer.compose())
    }
}

enum DetailsViewModelFactoryComposer: MainComposer {
    static func compose() -> DetailsViewModelFactory {
        DetailsViewModelFactoryImpl()
    }
}
