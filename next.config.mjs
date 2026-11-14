/** @type {import('next').NextConfig} */
const nextConfig = {
  outputFileTracingIncludes: {
    '/admin/practical-guide/handouts/*': ['./assets/paper3-handouts/*.pdf'],
  },
};
export default nextConfig;
