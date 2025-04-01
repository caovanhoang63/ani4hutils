import { Routes, Route, Navigate } from 'react-router-dom';
import Login from "./pages/login/Login.tsx";
import RootLayout from "./layouts/RootLayout.tsx";
import Dashboard from "./pages/dashboard/Dashboard.tsx";

function ProtectedRoute({ children  }: {children : React.ReactNode}) {
    const token = localStorage.getItem('token');
    return token ? children : <Navigate to="/login" replace />;
}

export default function Router() {
    return (
        <Routes>
            <Route
                path="/login"
                element={<Login/>}
            />
            <Route
                path="/"
                element={
                    <ProtectedRoute>
                        <RootLayout />
                    </ProtectedRoute>
                }
            >
                <Route
                    index
                    element={
                        <ProtectedRoute>
                            <Dashboard />
                        </ProtectedRoute>
                    }
                />
            </Route>
        </Routes>
    );
}