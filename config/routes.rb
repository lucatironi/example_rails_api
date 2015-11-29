Rails.application.routes.draw do
  resource :sessions, only: [:create, :destroy]
  resources :customers, only: [:index, :show, :create, :update, :destroy]

  cors_head = proc do
    [
      204,
      {
        'Content-Type'                 => 'text/plain',
        'Access-Control-Allow-Origin'  => CORS_ALLOW_ORIGIN,
        'Access-Control-Allow-Methods' => CORS_ALLOW_METHODS,
        'Access-Control-Allow-Headers' => CORS_ALLOW_HEADERS
      },
      []
    ]
  end
  match '/*path', to: cors_head, via: [:options, :head]
end
