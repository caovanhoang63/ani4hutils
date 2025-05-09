import {useNavigate} from "react-router-dom";

export default function TopBar(className: {className?: string }) {
    const navigate = useNavigate();
    return (
        <div className={`navbar bg-base-red shadow-sm ${className} space-x-4`}>
            {/*<div className="flex-none">
                <a href={"/"} className="btn btn-ghost text-xl">Ani4h</a>
            </div>*/}
            <div className="flex-1">
            </div>

            <label className="input">
                <input type="search" required placeholder="Search"/>
                <svg className="h-[1em] opacity-50" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                    <g strokeLinejoin="round" strokeLinecap="round" strokeWidth="2.5" fill="none" stroke="currentColor">
                        <circle cx="11" cy="11" r="8"></circle>
                        <path d="m21 21-4.3-4.3"></path>
                    </g>
                </svg>
            </label>

            <div className="flex">

                <div className="dropdown dropdown-end">
                    <div tabIndex={0} role="button" className="btn btn-ghost btn-circle avatar">
                        <div className="w-10 rounded-full">
                            <img
                                alt="Tailwind CSS Navbar component"
                                src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp"/>
                        </div>
                    </div>
                    <ul
                        tabIndex={0}
                        className="menu menu-sm dropdown-content bg-base-100 rounded-box z-1 mt-3 w-52 p-2 shadow">
                        <li>
                            <a className="justify-between">
                                Profile
                                <span className="badge">New</span>
                            </a>
                        </li>
                        <li><a>Settings</a></li>
                        <li><a onClick={e => {
                            e.preventDefault()
                            localStorage.removeItem("token")
                            localStorage.removeItem("refreshToken")
                            navigate('/login')
                        }}>Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    )
}

